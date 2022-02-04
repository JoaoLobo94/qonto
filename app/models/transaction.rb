class Transaction < ApplicationRecord
  belongs_to :bank_account, foreign_key: 'bank_account_id'
#We could have only one loop. If the current balance is negative, then we break the loop, and return false.
#For multiple instances in different load balancer we should wrap this up in a transactino to prevent deadlocks
#ammount should be float but in database is integer? cents will not be stored. Did not understand that
  def self.check_transaction(transactions)
    return false unless save_balance(transactions)

    TransactionWorker.perform_async(transactions)
  end

  def self.save_balance(transactions)
    bank_account = BankAccount.find_by(iban: transactions['organization_iban'],
                                       bic: transactions['organization_bic'])
    amount_to_transact = 0
    transactions['credit_transfers'].each do |transfer|
      amount_to_transact += transfer['amount'].to_f
    end
    current_balance = bank_account.balance_cents - amount_to_transact
    bank_account.update(balance_cents: current_balance)
  end
end

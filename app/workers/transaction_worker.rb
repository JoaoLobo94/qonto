class TransactionWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  #one job for each loop
  def perform(transactions)
    bank_account = BankAccount.find_by(iban: transactions['organization_iban'],
                                       bic: transactions['organization_bic'])
    transactions['credit_transfers'].each do |transfer|
      transfer_hash = {
        counterparty_name: transfer['counterparty_name'],
        counterparty_iban: transfer['counterparty_iban'],
        counterparty_bic: transfer['counterparty_bic'],
        amount_cents: transfer['amount'].to_f,
        amount_currency: 'EUR',
        bank_account_id: bank_account.id,
        description: transfer['description']
      }
      Transaction.create(transfer_hash)
    end
  end
end

class TransactionsController < ApplicationController
  def index
    render json: Transaction.all.as_json
  end

  def show
    render json: Transaction.find(params[:id])
  end

  def create
    if Transaction.check_transaction(parsed_transaction)
      render json: "Transactions updated", status: :created
    else
      render json: "Unprocessable entity", status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transactions)
  end

  def parsed_transaction
    return unless transaction_params

    transaction_file = File.read(transaction_params.tempfile)
    JSON.parse(transaction_file)
  end
end

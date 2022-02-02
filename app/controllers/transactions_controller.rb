class TransactionsController < ApplicationController
  def index
    render json: Transaction.all.as_json
  end

  def show
    render json: Transaction.find(params[:id])
  end

  def create
  end

  private

  def object_params
    params.require(:transaction).permit(:id)
  end
end

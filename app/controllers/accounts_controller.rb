class AccountsController < ApplicationController
  def index
    if params[:term]
      querier = Elastic::Query.new
      @accounts = querier.query(params[:field], params[:term]).map { |id| Account.find(id) }
      @avg_balance = querier.avg_balance
    else
      @accounts = Account.all
    end
  end

  def balance_search
    querier = Elastic::Query.new

    @accounts = querier.by_balance(params[:balance_from],
                                   params[:balance_to],
                                   params[:sort]).map { |id| Account.find(id) }

    render :index
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])

    @account.update_attributes(account_params)

    Elastic::Indexing.new.index_one(@account)

    redirect_to edit_account_path(@account)
  end

  def account_params
    params.require(:account).permit(:term, :name, :email, :address, :balance)
  end
end

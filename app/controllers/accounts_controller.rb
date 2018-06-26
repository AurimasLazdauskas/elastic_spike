class AccountsController < ApplicationController
  def index
    @accounts = if params[:term]
               Account.where(name: Elastic::Query.by_name(params[:term]))
             else
               Account.all
             end
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

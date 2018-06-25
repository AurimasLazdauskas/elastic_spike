class AccountsController < ApplicationController
  def index
    @accounts = if params[:term]
               Account.where(name: Elastic::Query.by_name(params[:term]))
             else
               Account.all
             end
  end

  def account_params
    params.require(:account).permit(:term)
  end
end

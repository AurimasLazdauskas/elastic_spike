class AccountsController < ApplicationController
  def index
    @accounts = if params[:term]
               Account.where('name LIKE ?', "%#{params[:term]}%")
             else
               Account.all
             end
  end

  def account_params
    params.require(:account).permit(:term)
  end
end

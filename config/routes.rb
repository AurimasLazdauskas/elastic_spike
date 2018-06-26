Rails.application.routes.draw do
  resources :accounts do
    collection do
      get 'balance_search'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

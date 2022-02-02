Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :transactions, only: [:index, :show, :create, :new]
  resources :bank_accounts,only: [:index, :update]
end

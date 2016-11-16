Rails.application.routes.draw do

  root 'main#index'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "dashboard" => "dashboards#index"
  get "view_payees" => "dashboards#view_payees"

  get "check" => "payee#verify_mobile"
  get "payables" => "payee#payables"
  patch "pay" => "payee#pay"

  resources :favours
  resources :payment_types
  resources :contracts
  resources :bills
  resources :items
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

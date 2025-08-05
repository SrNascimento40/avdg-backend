Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :users, only: [:index, :show, :create]
  resources :legal_cases, only: [:index, :show, :create, :update, :destroy] do
    resources :change_logs, only: [:index, :create]
    resources :messages, only: [:index, :create]
  end
  resources :messages, only: [:index, :create, :show, :update, :destroy]
  resources :notifications, only: [:index, :update]
  resources :invoices, only: [:index, :show, :create, :update, :destroy] do
    resources :payments, only: [:index, :show, :create, :update, :destroy]
  end

  get "/me", to: "users#me"
end

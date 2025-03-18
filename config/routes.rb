Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/sessions' }

  resources :users, only: [:index, :show]
  resources :legal_cases do
    resources :change_logs, only: [:index, :create]
    resources :messages, only: [:index, :create]
  end
  resources :notifications, only: [:index, :update]
  resources :invoices do
    resources :payments, only: [:create]
  end
end

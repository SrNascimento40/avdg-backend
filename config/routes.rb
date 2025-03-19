Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources :users, only: [:index, :show, :create]
  resources :legal_cases, only: [:index, :show, :create, :update, :destroy] do
    resources :change_logs, only: [:index, :create]
    resources :messages, only: [:index, :create]
  end
  resources :notifications, only: [:index, :update]
  resources :invoices do
    resources :payments, only: [:create]
  end
end

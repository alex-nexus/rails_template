Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'landing#index'

  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'

  resources :landing, only: 'index'
  resources :users

  namespace :admin do
    resources :dashboard, only: 'index'
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'landing#index'

  mount RailsAdmin::Engine => '/command_center', as: 'rails_admin'
end

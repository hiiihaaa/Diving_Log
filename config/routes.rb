Rails.application.routes.draw do

  root "logs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  resources :users

  resources :logs
end

Rails.application.routes.draw do

  root "logs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }

  devise_scope :user do
    post  'users',          to: 'users/registrations#create', as: :users
    get   'users/:id',      to: 'users/registrations#show',   as: :show_user
    get   'users/:id/edit', to: 'users/registrations#edit',   as: :edit_user
    patch 'users/:id',      to: 'users/registrations#update', as: :update_user
  end

  resources :logs
  resources :likes, only: [:create, :destroy]
end

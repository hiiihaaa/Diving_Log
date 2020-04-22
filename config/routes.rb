Rails.application.routes.draw do
  root "logs#index"

  resources :logs
end

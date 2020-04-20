Rails.application.routes.draw do
  root "logs#new"
  get "/logs/new_s2/", to: "logs#new_s2"

  resources :logs
end

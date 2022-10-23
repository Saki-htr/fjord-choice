Rails.application.routes.draw do
  root 'home#index'
  get 'tos', to: 'home#tos'
  get 'pp', to: 'home#pp'
  namespace :api do
    resources :issues, only: [:create]
    resources :pulls, only: [:create]
  end

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  resource :retirements, only: %i(create)
end

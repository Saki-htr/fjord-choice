Rails.application.routes.draw do
  namespace :api do
    resources :issues, only: [:create]
    resources :pulls, only: [:create]
  end
  root 'home#index'
  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure"
  resource :retirements, only: %i(create)
end

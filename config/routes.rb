Rails.application.routes.draw do
  namespace :api do
    resources :issues, only: [:create]
    resources :pulls, only: [:create]
  end
  root 'home#index'
  get "/auth/:provider/callback" => "sessions#create"
  resource :retirements, only: %i(create)
  resources :user_assigned_issues, only: %I[create destroy]
end

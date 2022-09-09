Rails.application.routes.draw do
  namespace :api do
    get 'pulls/create'
    resources :issues, only: [:create]
  end
  root 'home#index'
  get "/auth/:provider/callback" => "sessions#create"

  resource :retirements, only: %i(create)
end

Rails.application.routes.draw do
  namespace :api do
    get 'issues/create'
  end
  root 'home#index'
  get "/auth/:provider/callback" => "sessions#create"

  resource :retirements, only: %i(create)
  post "/" => "home#create"
end

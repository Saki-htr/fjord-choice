Rails.application.routes.draw do
  root 'home#index'
  get "/auth/:provider/callback" => "sessions#create"

  resource :retirements, only: %i(create)
end

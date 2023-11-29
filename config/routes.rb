Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    post 'users', to: 'users#create'
    get 'user/balance', to: 'users#balance'
    post 'teams', to: 'teams#create'
    post 'deposit', to: 'wallets#deposit'
    post 'withdraw', to: 'wallets#withdraw'
    post 'transfer', to: 'wallets#transfer'

    post 'login', to: 'authentications#login'

  end
end

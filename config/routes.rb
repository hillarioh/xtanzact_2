Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'authentication#login'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :create, :destroy]
      resources :accounts, only: [:index, :destroy] do
        post :transact, on: :collection
        post :transfer, on: :collection
      end
      get :transaction_history, to: 'transaction_lists#index'
    end
  end
end

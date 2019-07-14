# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :subscriptions
  namespace :api do
    namespace :v1 do
      resources :auth, only: [:create, :destroy]
      resources :suns, only: [:index, :show]
      # resources :compatibilities
      resources :compatibilities, only: [:index, :show]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      get 'users/:id/sun_compats', to: 'users#sun_compats'
      get 'users/:id/current_matches', to: 'users#current_matches'
      # get 'users/:id/updated_matches', to: 'users#updated_matches'
      get '/users/:user_id/chats', to: 'users#users_chats'

      # get '/user/auth' => 'sessions#auth'
      # post '/users/create' => 'sessions#create'
      post 'knock_token' => 'knock_token#create' # Get login token from Knock

      # resources :matches
      resources :matches, only: [:index, :show, :create, :update]
      patch 'matches/:id/accept', to: 'matches#accept'
      patch 'matches/:id/decline', to: 'matches#decline'
      resources :chats, only: [:index, :create]
      resources :conversations, only: [:create]
      mount ActionCable.server => '/cable'
      # small note: instead of modifying the config with the mount path, add the following line to your routes (in whichever namespace you want): `mount ActionCable.server => '/<your mount path here>` (edited) i.e. i have that line (with the path as cable) in the api/v1/ namespace, so when you want to connect to it you connect to `ws://localhost:3000/api/v1/cable`
    end
  end
  # mount ActionCable.server => '/cable'
end

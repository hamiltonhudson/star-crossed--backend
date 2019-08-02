# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :user_chats
  resources :subscriptions
  namespace :api do
    namespace :v1 do
      resources :auth, only: [:create, :destroy]
      resources :suns, only: [:index, :show]
      resources :compatibilities, only: [:index, :show]
      resources :users, only: [:index, :show, :create, :update, :destroy]
      get 'users/:id/sun_compats', to: 'users#sun_compats'
      get 'users/:id/current_matches', to: 'users#current_matches'
      get '/users/:user_id/chats', to: 'users#users_chats'
      resources :matches, only: [:index, :show, :create, :update]
      patch 'matches/:id/accept', to: 'matches#accept'
      patch 'matches/:id/decline', to: 'matches#decline'
      resources :chats, only: [:index, :create]
      resources :conversations, only: [:create]
      mount ActionCable.server => '/cable'
    end
  end
end

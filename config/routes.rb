# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :suns, only: [:index, :show]
      resources :compatibilities
      resources :users, only: [:index, :show, :create, :update, :destroy]
      get 'users/:id/sun_compats', to: 'users#sun_compats'
      get 'users/:id/current_matches', to: 'users#current_matches'
      get 'users/:id/updated_matches', to: 'users#updated_matches'
      resources :matches
    end
  end
end

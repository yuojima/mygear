Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :followings, :followers] do
      member do
      get :followings
      get :followers
    end
  end

  resources :posts, only: [:new, :show, :create, :destroy]
  resources :follow_users, only: [:create, :destroy]
  resources :gears, only: [:new]

end
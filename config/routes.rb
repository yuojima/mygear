Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'new/create'
  get 'new/destroy'
  get 'toppages/index'
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
      member do
      get :followings
      get :followers
    end
  end

  resources :posts, only: [:create, :destroy]
end
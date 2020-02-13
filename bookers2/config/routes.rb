Rails.application.routes.draw do
  devise_for :users
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  root to: 'home#top'
  get "home/about" => "home#about"
  end
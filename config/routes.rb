Rails.application.routes.draw do
  #get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :users
  resources :sessions

  resources :products,only: [:show]
  resources :categories,only: [:show]
  resources :shopping_carts,only: [:index, :create, :update, :destroy]
  resources :addresses
  resources :orders

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products do
      resources :product_images,only: [:index,:create,:destroy,:update,:edit]
    end
  end
end

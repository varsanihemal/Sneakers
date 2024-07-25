  Rails.application.routes.draw do
    get 'categories/show'
    get 'pages/casual'
    get 'pages/sports'
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

    resources :static_pages, only: [:show]
    resources :products, only: [:index, :show]
    resources :categories, only: [:show]
    devise_for :users
    resource :cart, only: [:show]


    root 'home#index'
    get 'collections', to: 'pages#collections'
    get 'casual', to: 'pages#casual'  # Add this route
    get 'sports', to: 'pages#sports'  # Add this route
    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'
  end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :static_pages, only: [:show]
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  devise_for :users
  resource :cart, only: [:show]


  root 'home#index'
  get 'collections', to: 'pages#collections'
  get 'men', to: 'pages#men'
  get 'women', to: 'pages#women'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :static_pages, only: [:show]
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :orders, only: [:new, :create, :show]
  resources :carts, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
  end

  root 'home#index'
  get 'collections', to: 'pages#collections'
  get 'casual', to: 'pages#casual'
  get 'sports', to: 'pages#sports'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'orders/get_tax_rates', to: 'orders#get_tax_rates'
end

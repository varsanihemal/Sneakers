Rails.application.routes.draw do
  # Admin routes for ActiveAdmin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Static pages
  get 'static_pages/:title', to: 'static_pages#show', as: :static_page

  # Products and categories
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  # User authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Orders routes
  resources :orders, only: [:index, :show, :create, :new, :edit, :update]

  # Carts and cart items
  resources :carts, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
  end

  # Root and other pages
  root 'home#index'
  get 'collections', to: 'pages#collections'
  get 'casual', to: 'pages#casual'
  get 'sports', to: 'pages#sports'
  get 'about', to: redirect('/static_pages/about')
  get 'contact', to: redirect('/static_pages/contact')

  # Search route
  get 'search_products', to: 'home#index', as: :search_products

  # Additional routes
  get 'orders/get_tax_rates', to: 'orders#get_tax_rates'
end

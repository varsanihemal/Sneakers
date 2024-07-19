Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :static_pages, only: [:show]
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  root 'home#index'
end

Rails.application.routes.draw do
  get '/', to: 'read#front_page', as: 'front_page'
  get '/index', to: 'read#index', as: 'index'
  get '/new_items', to: 'read#new_items', as: 'new_items'
  get '/category', to: 'read#category', as: 'category'
  get '/other', to: 'read#other', as: 'other'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

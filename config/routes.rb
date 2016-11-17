Rails.application.routes.draw do
  get '/', to: 'read#front_page', as: 'front_page'
  get '/index', to: 'read#index', as: 'index'
  get '/new_items', to: 'read#new_items', as: 'new_items'
  get '/items_on_sale', to: 'read#items_on_sale', as: 'items_on_sale'
  get '/category', to: 'read#category', as: 'category'
  get '/other', to: 'read#other', as: 'other'
  get '/item', to: 'read#item', as: 'item'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

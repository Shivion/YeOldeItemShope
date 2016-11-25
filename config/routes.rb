Rails.application.routes.draw do
  devise_for :users
  root to: 'read#front_page'
  get '/', to: 'read#front_page', as: 'front_page'
  get '/index', to: 'read#index', as: 'index'
  get '/new_items', to: 'read#new_items', as: 'new_items'
  get '/items_on_sale', to: 'read#items_on_sale', as: 'items_on_sale'
  get '/other', to: 'read#other', as: 'other'
  get '/item', to: 'read#item', as: 'item'
  get '/customer', to: 'read#edit_customer', as: 'edit_customer'
  post '/new_customer', to: 'read#new_customer', as: 'new_customer'
  post '/add_item_to_cart', to: 'read#add_item_to_cart', as: 'add_item_to_cart'
  post '/remove_item_from_cart',to: 'read#remove_item_from_cart', as: 'remove_item_from_cart'
  get '/cart', to: 'read#cart', as: 'cart'
  post '/checkout', to: 'read#checkout', as: 'checkout'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

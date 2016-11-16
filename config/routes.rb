Rails.application.routes.draw do
  get '/', to: 'read#front_page', as: 'front_page'
  get '/index', to: 'read#index', as: 'index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

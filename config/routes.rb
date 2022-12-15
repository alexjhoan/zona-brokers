Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  post 'newsletter_subscribe', to: 'welcome#newsletter_subscribe'

  resources :contact, only: [:new, :create]
  resources :posts, only: [:index, :show]
  resources :properties, only: [:show] do
    get :highlighted, on: :collection
    get :reference_search, on: :collection
    get :images, on: :member
    post :consult, on: :member
    post :consult_express, on: :member
  end

  get "/propiedades/:property_name/:id", to: 'properties#show'
  get "/proyectos/:property_name/:id", to: 'properties#show'
  get "/contact_us", to: 'contact#new'
  get "/about", to: 'welcome#about'
  get "/zona", to: 'welcome#zona'
  get "/:operation_type_name", to: 'properties#index', as: :properties, constraints: PropertyRouteConstraint
  get "/:operation_type_name/:property_type_name", to: 'properties#index', constraints: PropertyRouteConstraint
  get "/:operation_type_name/:property_type_name/:state_name", to: 'properties#index', constraints: PropertyRouteConstraint
  get "/:operation_type_name/:property_type_name/:state_name/:zone_name", to: 'properties#index', constraints: PropertyRouteConstraint

  post '/admin/update_styles', controller: 'admin/dashboard', action: 'update_styles'
end

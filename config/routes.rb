SocialReal::Application.routes.draw do
  resources :profiles

  get 'my_profile' => "profiles#show"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :users do
    get 'users/roles' => "users/roles#index"
    patch 'user/:user_id/role' => "users/roles#update"
    post 'users/roles' => "users/roles#show"
  end

  root 'home#index'

  get 'dashboard/' => 'dashboard#index'
  namespace :dashboard do
  end
end
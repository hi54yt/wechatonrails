Rails.application.routes.draw do
  root to: 'visitors#index'


  devise_for :users
  resources :users

  # Admin
  mount Upmin::Engine => '/admin'
end

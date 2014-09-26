# encoding: UTF-8
Rails.application.routes.draw do
  root to: 'visitors#index'


  devise_for :users
  resources :users

  resource :wechat, only:[:show, :create]

   ## wechat
  namespace 'wechat' do
    root to: 'home#index'

    get 'users',  to: 'home#users'
    get 'test',   to: 'home#test'
    get 'menu',   to: 'home#menu'
    get 'qrcode', to: 'home#qrcode'

    # post '/', to: 'events#subscribe', constraints: Wechat::Constraint.new('subscribe')
    # post '/', to: 'events#unsubscribe', constraints: Wechat::Constraint.new('unsubscribe')
    # post '/', to: 'events#menuclick', constraints: Wechat::Constraint.new('menuclick')
    # # post '/', to: 'events#input_event', constraints: Wechat::Router.new('event')
    #
    # post '/', to: 'texts#input', constraints: Wechat::Constraint.new('text')
    # post '/', to: 'images#input', constraints: Wechat::Constraint.new('image')
    # post '/', to: 'locations#input', constraints: Wechat::Constraint.new('location')
    # post '/', to: 'voices#input', constraints: Wechat::Constraint.new('voice')
    # post '/', to: 'wechat#input_music', constraints: Wechat::Constraint.new('music')
    # post '/', to: 'wechat#input_news', constraints: Wechat::Constraint.new('news')
    #
    # post '/', to: 'wechat#input_news', constraints: lambda {|r| r.params}
  end

  # Admin
  mount Upmin::Engine => '/admin'
end

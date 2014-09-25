# encoding: UTF-8
class Wechat::Router
  def initialize(type='text')
    @message_type = type
  end

  def matches?(request)
    xml_data = request.params[:xml]
    if xml_data and xml_data.is_a?(Hash)
      type = request.params[:xml][:MsgType]
      if type == 'event'
        event_type = request.params[:xml][:Event]
        case event_type
          when 'subscribe'
            type = 'subscribe'
          when 'unsubscribe'
            type = 'unsubscribe'
          when 'CLICK'
            type = 'menuclick'
        end
      end

      @message_type == type
    end
  end
end


Rails.application.routes.draw do
  root to: 'visitors#index'


  devise_for :users
  resources :users

   ## wechat
  namespace 'wechat' do
    root to: 'home#index'

    get 'test', to: 'home#test'
    get 'menu', to: 'home#menu'
    get 'qrcode', to: 'home#qrcode'

    post '/', to: 'events#subscribe', constraints: Wechat::Router.new('subscribe')
    post '/', to: 'events#unsubscribe', constraints: Wechat::Router.new('unsubscribe')
    post '/', to: 'events#menuclick', constraints: Wechat::Router.new('menuclick')
    # post '/', to: 'events#input_event', constraints: Wechat::Router.new('event')

    post '/', to: 'texts#input', constraints: Wechat::Router.new('text')
    post '/', to: 'images#input', constraints: Wechat::Router.new('image')
    post '/', to: 'locations#input', constraints: Wechat::Router.new('location')
    post '/', to: 'voices#input', constraints: Wechat::Router.new('voice')
    post '/', to: 'wechat#input_music', constraints: Wechat::Router.new('music')
    post '/', to: 'wechat#input_news', constraints: Wechat::Router.new('news')

    post '/', to: 'wechat#input_news', constraints: lambda {|r| r.params}
  end

  # Admin
  mount Upmin::Engine => '/admin'
end

# encoding: UTF-8
class Wechat::EventsController < Wechat::BaseController
  def subscribe
    wechat_openid = params[:xml][:FromUserName].to_s
    subscribe = WechatSubscribe.create(openid: wechat_openid)

    render 'wechat/subscribe', formats: :xml
  end

  def unsubscribe
    render 'wechat/unsubscribe', formats: :xml
  end

  def menuclick
    @request_event_key = params[:xml][:EventKey].to_s

    case @request_event_key
      when '3001'
    end

    @event = Event.find_by_key(@request_event_key)

    render 'wechat/feedback', formats: :xml
  end
end
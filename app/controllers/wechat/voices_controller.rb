# encoding: UTF-8
class Wechat::VoicesController < Wechat::BaseController
  def input
    # get the wechat user
    @wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    @media_id = params[:xml][:MediaId].to_s

    render 'wechat/voice', formats: :xml

  end
end
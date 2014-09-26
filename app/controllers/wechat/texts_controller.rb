# encoding: UTF-8
class Wechat::TextsController < Wechat::BaseController

  def input
    # get the wechat user
    @wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    @input = params[:xml][:Content].to_s

    render 'wechat/text', formats: :xml
  end
end
# encoding: UTF-8
class Wechat::ImagesController < Wechat::BaseController
  def input
    # get the wechat user
    @wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    image_url = params[:xml][:PicUrl].to_s

    # get the media Id
    @media_id = params[:xml][:MediaId].to_s

    # save the meida
    

    render 'wechat/image', formats: :xml
  end
end
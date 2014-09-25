# encoding: UTF-8
class Wechat::VoicesController < Wechat::BaseController
  def input
    # get the wechat user
    @wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    media_id = params[:xml][:MediaId].to_s

    @resource = Voice.new(media_id: media_id, path: '', status: 0)

    # if user not login, save for user 1, then change the owner if the user login
    user = User.find_by_wechat_id(@wechat_id)
    if user
      @resource.user_id = user.id
    else
      @resource.user_id = 1
    end
    @resource.wechat_id = @wechat_id

    # Save the meida and response
    if @resource.save
      if user
        render 'wechat/voice_success', formats: :xml
      else
        render 'wechat/login', formats: :xml
      end
    else
      render 'wechat/voice_error', formats: :xml
    end
  end
end
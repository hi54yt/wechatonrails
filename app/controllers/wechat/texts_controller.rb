# encoding: UTF-8
class Wechat::TextsController < Wechat::BaseController

  def input
    # get the wechat user
    wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    input = params[:xml][:Content].to_s

    TextInput.create(wechat_id: wechat_id, content: input)

	user = User.find_by_wechat_id(wechat_id)
    if user
      render 'wechat/text', formats: :xml
    else
      render 'wechat/text_unauth', formats: :xml
    end
  end
end
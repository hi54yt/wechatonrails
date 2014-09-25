# encoding: UTF-8
class Wechat::ImagesController < Wechat::BaseController
  def input
    # get the wechat user
    @wechat_id = params[:xml][:FromUserName].to_s
    # get the media Id
    image_url = params[:xml][:PicUrl].to_s

    # http://stackoverflow.com/questions/7339797/carrierwave-how-to-store-file-at-given-url
    # https://github.com/carrierwaveuploader/carrierwave#uploading-files-from-a-remote-location
    @image = Image.new(title: '来自微信', remote_path_url: image_url)

    user = User.find_by_wechat_id(@wechat_id)
    if user
      @image.user_id = user.id
    else
      @image.user_id = 1
      @image.wechat_id = @wechat_id
    end

    # 保存meida
    if @image.save
      if user
        render 'wechat/image_success', formats: :xml
      else
        render 'wechat/login', formats: :xml
        end
    else
      render 'wechat/image_error', formats: :xml
    end
  end
end
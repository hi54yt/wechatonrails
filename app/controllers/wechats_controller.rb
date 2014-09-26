class WechatsController < ApplicationController
  wechat_responder

  # 默认的文字信息responder
  on :text do |request, content|
    request.reply.text "echo: #{content}" #Just echo
  end


  # 当请求的文字信息内容为'help'时, 使用这个responder处理
  on :text, with:"help" do |request, help|
    request.reply.text "help content" #回复帮助信息
  end

  # 处理图片信息
  on :image do |request|
    a = '1'
    tmp_file = requret.as 'image'
    FileUtils.mv(tmp_file.path, "/var/tmp/1.jpg")

    request.reply.image(request[:MediaId]) #直接将图片返回给用户
  end
end
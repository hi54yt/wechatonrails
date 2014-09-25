# encoding: UTF-8
class Wechat::LocationsController < Wechat::BaseController

  def input
    render 'welcome', formats: :xml
  end
end
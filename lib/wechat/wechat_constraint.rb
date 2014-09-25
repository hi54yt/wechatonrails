# http://guides.rubyonrails.org/routing.html#advanced-constraints
# http://dev.tscolari.me/2012/09/19/complex-constraints-for-rails-routes/
# http://stackoverflow.com/questions/4207657/rails-routing-to-handle-multiple-domains-on-single-application
class Wechat::Constraint
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
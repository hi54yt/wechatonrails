# encoding: UTF-8

## TODO: for now config application.rb to fix require issue.
# require 'wechat/client.rb'
# require 'wechat/access_token'

class Wechat::HomeController < Wechat::BaseController
  # Disable CSRF
  skip_before_action :verify_authenticity_token
  before_action :check_signiture, only: [:index]

  # authorization
  def index
    # signature = params[:signature]
    # timestamp = params[:timestamp]
    # nonce = params[:nonce]

    render text: params[:echostr], status: 200, content_type: 'text/plain'
  end

  ## test
  def test
    render text: 'works', content_type: 'text/plain'
  end

  def users
    a = get("user/get")

    render text: 'works', content_type: 'text/plain'
  end

  def menu
    # menu = YAML.load(File.new(menu_yaml).read)
    menu = YAML.load_file('config/menu.yml')

    menu_json = JSON.generate(menu)
    self.post('menu/create', menu_json)

    render text: 'success', content_type: 'text/plain'
  end

  def qrcode
    self.post('qrcode/create', '')

    render text: 'success', content_type: 'text/plain'
  end

  protected

  def get path, headers={}
    with_access_token(headers[:params]){|params| client.get path, headers.merge(params: params)}
  end

  ## menu
  def post path, payload, headers = {}
    api_base = 'https://api.weixin.qq.com/cgi-bin/'

    appid = Rails.application.secrets.wechat_appid
    secret = Rails.application.secrets.wechat_secret
    token_file = Rails.application.secrets.wechat_access_token

    @client = Wechat::Client.new(api_base)
    @access_token = Wechat::AccessToken.new(@client, appid, secret, token_file)
    @access_token_path = @access_token.token

    with_access_token(headers[:params]) { |params| @client.post path, payload, headers.merge(params: params) }
  end

  def with_access_token params={}, tries=2
    begin
      params ||= {}
      yield(params.merge(access_token: @access_token_path))
    rescue Wechat::AccessTokenExpiredError => ex
      access_token.refresh
      retry unless (tries -= 1).zero?
    end
  end

  private

  def generate_signiture
    if params[:timestamp] && params[:nonce]
      wechat_token = Rails.application.secrets.wechat_token
      signature = [wechat_token, params[:timestamp], params[:nonce]].sort
      Digest::SHA1.hexdigest(signature.join)
    end
  end

  def valid_signiture?
    params[:signature] ? generate_signiture == params[:signature] : false
  end

  def check_signiture
    if !valid_signiture?
      head 401, :content_type => 'text/html' unless valid_signiture?
    end
  end
end
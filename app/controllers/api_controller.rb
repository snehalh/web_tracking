class ApiController < ApplicationController
  before_action :cors_preflight_check
  before_action :check_content_type 
  around_action :catch_errors
  after_action :add_header

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS, PATCH'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, X-Request-Origin'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  def add_header
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    response_type = (params["format"] == "html") ? 'text/html' : "application/json"
    headers['Content-Type'] = @content_type || response_type
    headers["if_modified_since off"] = "off"
    # headers['Token'] = token
  end

  def check_content_type
    if request.method == 'POST' || request.method == 'PATCH' || request.method == 'PUT'
      unless request.content_type.in?(['application/json','multipart/form-data'])
        render_api_error(12, 400, 'request', "Only content type application/json is accepted.  Your content type: #{request.content_type}")
      end
    end
  end

  def catch_errors
    begin
      yield
    rescue Exception => e
      Rails.logger.error("Unhandled API Error: #{e.to_s}.  Backtrace:\n#{e.backtrace.join("\n")}")
      render_api_error(02, 500, 'server', "API internal error: #{e.to_s}")
    end
  end
end

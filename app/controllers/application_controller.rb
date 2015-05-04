class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  API_KEY="1948f104-b8fb-4787-894f-79821a2d45b0"

  def redis_connection
    if Rails.env.development?
      return "redis://localhost:6379"
    else
      return ENV["REDISTOGO_URL"]
    end
  end

  def connection
    if @connection.nil?
      @connection =  Lol::Client.new API_KEY, {
        region: "na",
        redis: redis_connection,
        ttl: 900
      }
    end

    @connection

  end

end

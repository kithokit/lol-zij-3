require 'lol'
require 'singleton'
module Lolconnection
  extend ActiveSupport::Concern

  API_KEY="1948f104-b8fb-4787-894f-79821a2d45b0"
  @@connection = nil

  def self.redis_connection
    if Rails.env.development?
      return "redis://localhost:6379"
    else
      return ENV["REDISTOGO_URL"]
    end
  end

  def self.connection
    if @@connection.nil?
      @@connection =  Lol::Client.new API_KEY, {
        region: "na",
        redis: self.redis_connection,
        ttl: 900
      }
    end
    @@connection
  end
end

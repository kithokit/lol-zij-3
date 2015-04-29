require 'lol'
class ProfilesController < ApplicationController

  API_KEY="1948f104-b8fb-4787-894f-79821a2d45b0"

  def connection
    if @connection.nil?
      @connection =  Lol::Client.new API_KEY, {region: "na"}
    end
    @connection
  end

  def index
    @stats = connection.stats.summary(43796077)
    @win = @stats.detect { |a| a.player_stat_summary_type == "RankedSolo5x5" }.wins
    @losses = @stats.detect { |a| a.player_stat_summary_type == "RankedSolo5x5" }.losses
  end
end

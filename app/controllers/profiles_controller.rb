require 'lol'
class ProfilesController < ApplicationController

  def index
    default_players
    render "index"
  end

  def search
    players = parse_query params['q']
    @search_profiles = players.map { |p|
      Profile.new(p) rescue { :name => p }
    }
    index
  end

  def parse_query q
    players = q.split(";")
    players
  end

  def default_players
    if @profile.nil?
      players = ["kithokit", "ringopak", "Team Cap", "yamsaihoi"]
      @profiles = []
      players.each { |p|
        profile = Profile.new(p) rescue nil
        @profiles << profile
      }
    end
    @profiles
  end
end

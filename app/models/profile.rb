class Profile

  include Lolconnection
  attr_accessor :summoner_id
  attr_accessor :name
  attr_accessor :stats
  attr_accessor :win
  attr_accessor :loss
  attr_accessor :winrate
  attr_accessor :tier
  attr_accessor :onfire

  def initialize name
    @name = name
    @summoner_id = summoner_id
    leagueinfo
  end

  def summoner_id
    if @summoner_id.nil?
      @summoner_id = connection.summoner.by_name(@name)
      @summoner_id.first.id.to_s
    end
  end

  def leagueinfo
    if @leagueinfo.nil?
      @leagueinfo = connection.league.get(@summoner_id)
      @leagueinfo = @leagueinfo[@summoner_id].first
    end
    @leagueinfo
  end

  def infodetail
    if @infodetail.nil?
         @infodetail = leagueinfo.entries.detect { |a| a.player_or_team_id == @summoner_id }
    end
    @infodetail
  end

  def tier
    if @tier.nil?
      tier = leagueinfo.tier
      division = infodetail.division
      @tier = tier + " " + division
    end
    @tier
  end

  def winrate
    unless win.nil? or loss.nil?
      (win.to_f/(win.to_f + loss.to_f)* 100).round(1)
    end
  end

  def win
    @win || @infodetail.wins
  end

  def loss
    @loss = @infodetail.losses
  end

  def onfire
    @onfire = @infodetail.is_hot_streak
  end

end

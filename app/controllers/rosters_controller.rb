class RostersController < ApplicationController

  def index
    @team = Team.first
    @players = @team.players
    @roster = @team.roster
  end
end

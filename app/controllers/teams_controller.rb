class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
    @players = @team.players
    @roster = @team.roster
  end

  def index
    @teams = Team.all
  end

end

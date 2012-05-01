class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
    @players = @team.players
    @roster = @team.roster
  end

  def index
    @team = Team.find(3)
    @players = @team.players
    @roster = @team.roster
    render "show"
  end
end

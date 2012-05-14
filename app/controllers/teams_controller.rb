class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
    @players = @team.players
    @roster = @team.roster
    @rosters = Roster.all.sort{|x, y| x.name <=> y.name}
  end

  def index
    @team = Team.find(3)
    @players = @team.players
    @roster = @team.roster
    @rosters = Roster.all.sort{|x, y| x.name <=> y.name}
    render "show"
  end
end

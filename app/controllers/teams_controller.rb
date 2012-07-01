class TeamsController < ApplicationController

  def show
    @roster = Roster.find_by_name(params[:id].gsub("_", " "))
    @team = @roster.teams.first
    @players = @team.players
    @rosters = Roster.all.sort{|x, y| x.name <=> y.name}
  end

  def index
    @team = Team.all[rand(Team.count)]
    @players = @team.players
    @roster = @team.roster
    @rosters = Roster.all.sort{|x, y| x.name <=> y.name}
    render "show"
  end

  def download_pdf
    players = params[:team].delete(:players)
    team = Team.new(params[:team])
    players.each do |index, player|
      team.players.new(player)
    end
    raise team.players.first.st
  end
end

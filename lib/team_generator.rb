class TeamGenerator

  def initialize(team)
    @team = team
    @pdf = Prawn::Document.new(:page_layout => :landscape)
  end

  def generate
    player_array = @team.players.map do |player|
      [player.playerNum, player.name, player.position.name, player.mv, player.st, player.ag, player.av, player.cost]
    end
  	@pdf.table player_array
  end

  def render
    generate
    @pdf.render
  end
end
class TeamGenerator

  def initialize(team)
    @team = team
    @pdf = Prawn::Document.new(:page_layout => :landscape)
    @stat_green = "#038F03"
  end

  def generate
    @pdf.text @team.name.gsub("+", " "), :align => :center, :size => 24
    @pdf.text " "
    num_col_width = 27

    widths = [num_col_width, 90, 130, num_col_width, num_col_width, num_col_width, num_col_width, 325, 40]
    headers = [["", "Name", "Position", "Ma", 
             "St", "Ag", "Av", "Skills", "Cost"]]
    player_array = @team.players.map do |player|
      @plus_st = @plus_ag = @plus_mv = @plus_av = 0
      cost =  if (player.skills && player.skills.select{|k,v| v['type'] != 'default'}.present?) 
                green(player.cost) 
              else
                player.cost
              end
      skills = format_skills(player.skills)
      [ player.playerNum,
        player.name.gsub("+", " "),
        player.position.name.gsub("+", " "),
        @plus_mv > 0 ? green(player.mv) : player.mv, 
        @plus_st > 0 ? green(player.st) : player.st, 
        @plus_ag > 0 ? green(player.ag) : player.ag, 
        @plus_av > 0 ? green(player.av) : player.av, 
        skills,
        cost
      ]
    end
  	@pdf.table(headers + player_array, :row_colors => %w[cccccc ffffff],
                                       :column_widths => widths,
                                       :header => true,
                                       :cell_style => {:inline_format => true})
  end

  def render
    generate
    @pdf.render
  end


  private

  def green(text)
    "<color rgb='#{@stat_green}'>#{text}</color>"
  end

  def format_skills(skills)
    return "" unless skills.present?
    skills.map do |k,v| 
      skill_type, name = v["type"], v["name"]
      name = name.gsub("+", " ")
      case skill_type
      when "normal"
        "<color rgb='#3A87AD'>#{name}</color>"
      when "double"
        "<color rgb='#468847'>#{name}</color>"
      when "mv"
        @plus_mv += 1
        "<color rgb='#F89406'>+#{name.titlecase.strip}</color>"     
      when "av"
        @plus_av += 1
        "<color rgb='#F89406'>+#{name.titlecase.strip}</color>"     
      when "ag"
        @plus_ag += 1
        "<color rgb='#BE06F8'>+#{name.titlecase.strip}</color>"     
      when "st"     
        @plus_st +=1 
        "<color rgb='#953B39'>+#{name.titlecase.strip}</color>"  
      else
        name
      end
    end.join(", ")
  end
end
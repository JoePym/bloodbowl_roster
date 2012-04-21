# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Team
  constructor: (table) ->
    @table = table
    @positions = $(table).data("positions")
    @players = []
    $(table).find('tr').each (index, playerRow) =>
      player = new Player(this, playerRow)
      @players.push(player)
    this.setDisabledPositions()

  setDisabledPositions: ->
    $(@positions).each (index, position) => 
      maximum = position.maximum
      members = @players.filter (player) -> 
        return player.position.name == position.name
      if members.length >= position.maximum
        $(@players).each (index, player) ->
          player.row.find("option").each (index, opt) ->
            $(opt).attr("disabled", "disabled") if $(opt).text() == position.name
      else
        $(@players).each (index, player) ->
          player.row.find("option").each (index, opt) ->
            $(opt).removeAttr("disabled") if $(opt).text() == position.name
    
$.Team = Team






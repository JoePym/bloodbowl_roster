# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Team
  constructor: (positions_table, team_details_table, team_name) ->
    @team_details_table = team_details_table
    @team_name = team_name
    @positions_table = positions_table
    @positions = $(positions_table).data("positions")
    @players = []
    $(positions_table).find('tr').each (index, playerRow) =>
      player = new Player(this, playerRow)
      @players.push(player)
    this.setDisabledPositions()
    this.detailsHandlers()

  detailsHandlers: ->
    $(@team_details_table).find('td .text').on "click", ->
      $(this).hide()
      $(this).siblings(".inputs").show()
      $(this).siblings(".inputs").children().focus()
    $(@team_details_table).find('td .inputs input').on "blur", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").show()
    $(@team_details_table).find('td .inputs input').on "change", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").text($(this).val())
      $(this).parents(".inputs").siblings(".text").show()

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






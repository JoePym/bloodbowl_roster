# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Team
  constructor: (positions_table, team_details_table, team_name) ->
    @team_details_table = team_details_table
    @team_name = $('.teamName')
    @positions_table = positions_table
    @positions = $(positions_table).data("positions")
    @rerolls = @team_details_table.find(".rerolls .text").text()
    @cheerleaders = @team_details_table.find(".cheerleaders .text").text()
    @assistant_coaches = @team_details_table.find(".cheerleaders .text").text()
    @fanfactor = @team_details_table.find(".fanfactor .text").text()
    @players = []
    $(positions_table).find('tr').each (index, playerRow) =>
      player = new Player(this, playerRow)
      @players.push(player)
    this.setDisabledPositions()
    this.detailsHandlers(@team_details_table)
    this.detailsHandlers(@team_name)

  detailsHandlers: (target)->
    $(target).find('.text').on "click", ->
      $(this).hide()
      $(this).siblings(".inputs").show()
      $(this).siblings(".inputs").children().focus()
    $(target).find('.inputs input').on "blur", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").show()
    $(target).find('.inputs input').on "change", (e) =>
      input = $(e.delegateTarget)
      $(input).parents(".inputs").hide()
      $(input).parents(".inputs").siblings(".text").text($(input).val())
      $(input).parents(".inputs").siblings(".text").show()
      if $(input).parents('.inputs').data("cost")
        old_cost =  this[$(input).parents('.inputs').data("attribute")]*$(input).parents('.inputs').data("cost")*1
        new_cost = $(input).parents('.inputs').data("cost")*$(input).val()*1
        this.updateTV(new_cost - old_cost)
        this[$(input).parents('.inputs').data("attribute")] = $(input).val()



  updateTV: (change) -> 
    tv_box = $(@team_details_table).find("tr.teamValue td.tv")
    cost = tv_box.text().replace("k", "")
    tv_box.text((cost*1 + change) + "k" )

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






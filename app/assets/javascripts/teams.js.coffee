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
    $(positions_table).find('tr.player').each (index, playerRow) =>
      player = new Player(this, playerRow)
      @players.push(player)
    this.setDisabledPositions()
    this.detailsHandlers(@team_details_table)
    this.detailsHandlers(@team_name)
    this.newPlayerHander()

  detailsHandlers: (target)->
    $(target).find('.text').on "click", ->
      $(this).hide()
      $(this).siblings(".inputs").show()
      $(this).siblings(".inputs").children().focus()
    $(target).find('.inputs input, .inputs select').on "blur", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").show()
    $(target).find('.inputs select').on "change", (e) =>
      input = $(e.delegateTarget)
      old_status = $(input).parents(".inputs").siblings(".text").text()
      $(input).parents(".inputs").hide()
      $(input).parents(".inputs").siblings(".text").text($(input).val())
      $(input).parents(".inputs").siblings(".text").show()
      new_status = $(input).val()
      if old_status != new_status
        if old_status == "No"
          this.updateTV(50)
        else
          this.updateTV(-50)

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


  newPlayerHander: ->
    row = $(@positions_table).find('tr.newPlayer')
    $(row).find('td .text').on "click", ->
      $(this).hide()
      $(this).siblings(".inputs").show()
      $(this).siblings(".inputs").children().focus()
    $(row).find('td .inputs select, input').on "blur", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").show()
    $(@positions_table).find('tr.newPlayer td.position select').on "change", =>
      row = $(@positions_table).find('tr.newPlayer')
      unless row.find('td.position select').val() == "cancel"
        position= row.find('td.position select option:selected').data("position")
        row.find('td.position select').val("cancel")
        row.find('td.position select').blur()
        this.addPlayer(position)
        if $(@positions_table).find('tr.player').length >= 16
          $(@positions_table).find('tr.newPlayer').hide()

      else 
        row.find('td.position select').val("cancel")
        row.find('td.position select').blur()

  toJSON: ->
    name:              @team_name.text().trim(),
    rerolls:           @rerolls,
    cheerleaders:      @cheerleaders,
    assistant_coaches: @assistant_coaches,
    fanfactor:         @fanfactor,
    tv:                $(@team_details_table).find("td.tv").text().trim(),
    gold:              $(@team_details_table).find('td.gold .text').text().trim(),
    players:           @players.map (p) -> p.toJSON()

  addPlayer: (position) ->
    new_row = $(@positions_table).find('tr.newPlayer').clone()
    new_row.data("position", position)
    new_row.find("td:not(.position, .skills, .name)").text("0")
    new_row.removeClass("newPlayer")
    new_row.addClass("player")
    new_row.find("td.name, td.skills").addClass("clickable")
    new_row.find("td.name .text").text("Rookie")
    new_row.find("td.playerNum").text($(@positions_table).find(".player").length + 1)
    new_row.find("td.position select option:first").remove()
    new_row.find("td.position .text").text(position.name)
    new_row.find("td.position select").append("<option value='delete'> Remove this player</option>")
    new_player = new Player(this, new_row)
    new_player.addPosition(position)
    new_row.insertBefore($(@positions_table).find('tr.newPlayer'))
    @players.push(new_player)
    this.setDisabledPositions()

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
        $(@positions_table).find("td.position option").each (index, opt) ->
          $(opt).attr("disabled", "disabled") if $(opt).text() == position.name
      else
        $(@positions_table).find("td.position option").each (index, opt) ->
          $(opt).removeAttr("disabled") if $(opt).text() == position.name
    
$.Team = Team






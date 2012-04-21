

$(document).ready ->
  team = new Team($("table.roster"))
  $('tr').each (index, playerRow) ->
    player = new Player(team, playerRow)

  $('td .text').on "click", ->
    $(this).hide()
    $(this).siblings(".inputs").show()
    $(this).siblings(".inputs").children().focus()
  $('td .inputs select, input').on "blur", ->
    $(this).parents(".inputs").hide()
    $(this).parents(".inputs").siblings(".text").show()
  $('td .inputs select, input').on "change", ->
    $(this).parents(".inputs").hide()
    $(this).parents(".inputs").siblings(".text").text($(this).val())
    $(this).parents(".inputs").siblings(".text").show()
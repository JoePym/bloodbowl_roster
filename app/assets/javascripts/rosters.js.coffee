# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('tr').each (index, playerRow) ->
    player = new Player(playerRow)

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

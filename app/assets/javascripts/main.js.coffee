$(document).ready ->
  team = new Team($("table.team"), $("table.teamDetails"), $(".teamName"))
  $('.dropdown-toggle').dropdown()
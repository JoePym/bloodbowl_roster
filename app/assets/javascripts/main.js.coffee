#define array deletion method to help removing players
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

$(document).ready ->
  team = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
  ts = new TeamSlider('.teamBox')
  $('.dropdown-toggle').dropdown()
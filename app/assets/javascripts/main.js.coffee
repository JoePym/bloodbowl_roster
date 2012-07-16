#define array deletion method to help removing players
Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

$(document).ready ->
  window.skillCosts =  
    'normal': 20
    'double': 30
    'st': 50
    'ag': 40
    'av': 30
    'ma': 30
    'forbidden': 30
  team = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
  skillCostSelector = new SkillOptions(team)
  ts = new TeamSlider('.teamBox')
  $('.dropdown-toggle').dropdown()
  $('.colorbox').colorbox({inline: true, width: "50%"})
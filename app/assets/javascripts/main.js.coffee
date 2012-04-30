$(document).ready ->
  team = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
  $('.dropdown-toggle').dropdown()
  $('.left.arrow').click ->
    if($(".teamSlider").css("margin-left").replace("px", "")*1 < 0) 
      $('.teamSlider').animate({"margin-left": "+=62px"})
  $('.right.arrow').click ->
    team_offset = $(".teamSlider .team").length*62 - 6*62
    if $(".teamSlider").css("margin-left").replace("px", "")*1 > (0 - team_offset) 
      $('.teamSlider').animate({"margin-left": "-=62px"})
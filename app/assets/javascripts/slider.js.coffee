class TeamSlider 
  constructor: (team_box) ->
    @container = $(team_box)
    @teams = $.makeArray($(team_box).find(".team"))
    @slider = $(team_box).find(".teamSlider")
    @team_width = @container.find(".team:first").outerWidth(true)
    @slider_width = @team_width * @slider.find(".team").length
    @slider.width(@slider_width)
    this.setInitialPosition()
    this.arrowHandlers()

  setInitialPosition: ->
    container_width = @container.find(".sliderInnerContainer").outerWidth()
    visible_teams = container_width/@team_width
    #we are implementing this by taking the number of visible teams, dividing it by 2 to find the leftmost visible team
    #then moving the slider bar such that it is.
    selected_index = @teams.indexOf(@container.find('.team.selected')[0])
    leftmost = selected_index - visible_teams/2
    rightmost = selected_index + visible_teams/2
    return if leftmost <= 0
    if rightmost >= @teams.indexOf(@container.find('.team:last')[0])
      $('.teamSlider').css
        "margin-left" : "-#{@slider_width - (visible_teams*@team_width)}px"
    else      
      $('.teamSlider').css
        "margin-left" : "-#{Math.round(leftmost)*@team_width}px"
  
  arrowHandlers: -> 
    @container.find('.left.arrow').click =>
      slider_margin = @slider.css("margin-left").replace("px", "")*1
      if slider_margin < 0 && slider_margin >(0- @team_width)
         @slider.stop().animate
          'margin-left': "0px"       
      else if(slider_margin < 0) 
        @slider.stop().animate
          'margin-left': "+=#{@team_width}px"

    $('.right.arrow').click =>
      slider_margin = @slider.css("margin-left").replace("px", "")*1
      container_width = @container.find(".sliderInnerContainer").outerWidth()
      team_offset = 0 - (slider_margin/@team_width - container_width/@team_width)
      team_gap = @slider.find(".team").length - team_offset
      if team_gap > 1
        $('.teamSlider').stop().animate
          "margin-left": "-=#{@team_width}px"
      else if team_gap > 0
        $('.teamSlider').stop().animate
          "margin-left": "-=#{@team_width*team_gap}px"      


this.TeamSlider = TeamSlider
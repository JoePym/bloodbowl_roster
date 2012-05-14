class TeamSlider 
  constructor: (team_box) ->
    @container = $(team_box)
    @teams = $.makeArray($(team_box).find(".team"))
    @slider = $(team_box).find(".teamSlider")
    @team_width = @container.find(".team:first").outerWidth(true)
    @slider_width = @team_width * @slider.find(".team").length
    @slider.width(@slider_width)
    this.arrowHandlers()

  arrowHandlers: -> 
    @container.find('.left.arrow').click =>
      slider_margin = @slider.css("margin-left").replace("px", "")*1
      if(slider_margin < 0) 
        @slider.animate
          'margin-left': "+=#{@team_width}px"

    $('.right.arrow').click =>
      slider_margin = @slider.css("margin-left").replace("px", "")*1
      container_width = @container.find(".sliderInnerContainer").outerWidth()
      team_offset = 0 - (slider_margin/@team_width - container_width/@team_width)
      if team_offset < @slider.find(".team").length
        $('.teamSlider').animate
          "margin-left": "-=#{@team_width}px"


$.TeamSlider = TeamSlider
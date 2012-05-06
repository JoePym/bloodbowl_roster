class Player
  constructor: (team, row) ->
    @team = team
    @row = $(row)
    this.skillHandlers()
    @position = @row.data("position")
    @addedSkills = []
    this.positionHandlers()
    this.genericHandlers()

  normalSkills: ->
    [].concat.apply [], $(@position.normal_skills).map((index, text) ->
      Skill[text]()
    )

  doubleSkills: ->
    [].concat.apply [], $(@position.double_skills).map((index, text) ->
      Skill[text]()
    )    

  skillJson: -> 
    default_skills = $(@row).find(".defaultSkills .label").map (index, skill) ->
      type: 'default'
      name: $(skill).text().trim()
    @addedSkills.map((s) -> s.toJson()).concat($.makeArray(default_skills))

  toJSON: ->
    playerNum: $(@row).find(".playerNum").text()*1,
    name:      $(@row).find(".name .text").text(),
    mv:        $(@row).find(".mv").text()*1,
    st:        $(@row).find(".st").text()*1,
    ag:        $(@row).find(".ag").text()*1,
    av:        $(@row).find(".av").text()*1,
    skills:    this.skillJson()
    cost:      @row.find("td.cost").text()

  removePosition: ->
    position = @position
    mv = $(@row).find(".mv")
    mv.text(mv.text()*1 - position.mv)
    st = $(@row).find(".st")
    st.text(st.text()*1 - position.st)
    ag = $(@row).find(".ag")
    ag.text(ag.text()*1 - position.ag)
    av = $(@row).find(".av")
    av.text(av.text()*1 - position.av)
    cost_cell = @row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 - position.cost) + "k" )
    @team.updateTV(0 - position.cost)
    @row.find(".defaultSkills").html("")
    $(@addedSkills).each (index, skill) ->
        skill.removeCost()

  addPosition: (position) ->
    mv = $(@row).find(".mv")
    mv.text(mv.text()*1 + position.mv)
    st = $(@row).find(".st")
    st.text(st.text()*1 + position.st)
    ag = $(@row).find(".ag")
    ag.text(ag.text()*1 + position.ag)
    av = $(@row).find(".av")
    av.text(av.text()*1 + position.av)
    cost_cell = @row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 + position.cost) + "k" )
    @team.updateTV(position.cost)
    @position = position   
    $(position.default_skills).each (index, skill) =>
      @row.find(".defaultSkills").append("<span class='label label-default'>#{skill}</span>")
    $(@addedSkills).each (index, skill) ->
      skill.addCost()
      skill.recolor()

  positionHandlers: ->
    @row.find('td.position select').on "change", =>
      this.removePosition()
      this.addPosition(@row.find('td.position select option:selected').data("position"))
      @team.setDisabledPositions()

  genericHandlers: ->
    $(@row).find('td .text').on "click", ->
      $(this).hide()
      $(this).siblings(".inputs").show()
      $(this).siblings(".inputs").children().focus()
    $(@row).find('td .inputs select, input').on "blur", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").show()
    $(@row).find('td .inputs select, input').on "change", ->
      $(this).parents(".inputs").hide()
      $(this).parents(".inputs").siblings(".text").text($(this).val())
      $(this).parents(".inputs").siblings(".text").show()

  skillHandlers: ->
    skill_cell = @row.find("td.skills")
    skill_cell.find(".skill-list").sortable()
    skill_cell.on "click", ->
      skill_cell.find("input").hide()
      $(this).children("input").show()
      $(this).children("input").focus()
    skill_cell.find('input').on "blur", ->
      $(this).hide()
    skill_cell.find('label').on "click", (e) ->
      e.stopPropagation()
      $(this).hide()
    skill_cell.find('input').on "change", =>
      input = skill_cell.find("input")
      $(input).hide()
      for skill_text in $(input).val().split(",")
        skill = new Skill(this, $.trim(skill_text), skill_cell.find(".skill-list"))
        this.addedSkills.push skill
      $(input).val("")


$.Player = Player

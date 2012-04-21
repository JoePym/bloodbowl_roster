class Player
  constructor: (team, row) ->
    @team = team
    @row = $(row)
    this.skillHandlers()
    @position_info = @row.data("position")
    @addedSkills = []
    this.positionHandler()

  normalSkills: ->
    [].concat.apply [], $(@position_info.normal_skills).map((index, text) ->
      Skill[text]()
    )

  doubleSkills: ->
    [].concat.apply [], $(@position_info.double_skills).map((index, text) ->
      Skill[text]()
    )    

  removePosition: ->
    position = @position_info
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
    @position_info = position   
    $(position.default_skills).each (index, skill) =>
      @row.find(".defaultSkills").append("<span class='label'>#{skill}</span>")
    $(@addedSkills).each (index, skill) ->
      skill.addCost()
      skill.recolor()

  positionHandler: ->
    @row.find('td.position select').on "change", =>
      this.removePosition()
      this.addPosition(@row.find('td.position select option:selected').data("position"))

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

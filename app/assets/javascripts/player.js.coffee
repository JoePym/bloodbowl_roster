class Player
  constructor: (row) ->
    @row = $(row)
    this.skillHandlers()

  normalSkills: ->
    [].concat.apply [], @row.data("normal-accesses").map((text) ->
      Skill[text]()
    )

  doubleSkills: ->
    [].concat.apply [], @row.data("double-accesses").map((text) ->
      Skill[text]()
    )    

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
      $(input).val("")

$.Player = Player

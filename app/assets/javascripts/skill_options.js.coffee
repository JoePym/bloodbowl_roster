class SkillOptions
  constructor: (team) ->
    @team = team
    @form = $('#skillOptions')
    @form.on "change", "input.skill", (ev)=>
      input = $(ev.target)
      key = $(input).data("type")
      window.skillCosts[key] = $(input).val()*1
      for player in @team.players
        for skill in player.addedSkills
          skill.recost()

this.SkillOptions = SkillOptions
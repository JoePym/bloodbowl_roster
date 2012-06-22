class Skill
  constructor: (player, text, skillList) ->
    @text = text
    @player = player
    @lctext = text.toLowerCase()
    @label = this.addTo(skillList)

  @general: -> 
    ["Block", "Dauntless", "Dirty Player", "Fend", "Frenzy", "Kick", "Kick-Off Return", "Pass Block", "Pro", "Shadowing",
     "Strip Ball", "Sure Hands", "Tackle", "Wrestle"]
  
  @agility: -> 
    ["Catch", "Diving Catch", "Diving Tackle", "Dodge", "Jump Up", "Leap", "Side Step", "Sneaky Git", "Sprint", "Sure Feet"]

  @passing: -> 
    ["Accurate", "Dump-Off", "Hail Mary Pass", "Leader", "Nerves of Steel", "Pass", "Safe Throw"]

  @strength: -> 
    ["Break Tackle", "Grab", "Guard", "Juggernaut", "Mighty Blow", "Multiple Block", "Piling On", "Stand Firm",
     "Strong Arm", "Thick Skull"]
  
  @mutation: -> 
    ["Big Hand", "Claw", "Claws", "Disturbing Presence", "Extra Arms", "Foul Appearance", "Horns", "Prehensile Tail", "Tentacles",
     "Two Heads", "Very Long Legs"]
  
  @extraordinary : -> 
    ["Always Hungry", "Animosity", "Ball & Chain", "Blood Lust", "Bombadier", "Bone-head", "Chainsaw", "Decay",
     "Fan Favourite", "Hypnotic Gaze", "Loner", "No Hands", "Nurgle's Rot", "Really Stupid", "Regeneration", "Right Stuff",
      "Secret Weapon", "Stab", "Stakes", "Stunty", "Take Root", "Throw Team-Mate", "Titchy", "Wild Animal"]
  @all: ->
    [].concat.apply([], [Skill.general(), Skill.agility(), Skill.passing(), Skill.strength(), Skill.extraordinary()])

  isNormal: ->
    @player.normalSkills().some (skill) =>
      return this.correctSpelling(skill) == this.correctSpelling(@lctext)    
  isDouble: ->
    @player.doubleSkills().some (skill) =>
      return this.correctSpelling(skill) == this.correctSpelling(@lctext)    
  isExtraordinary: ->
    Skill.extraordinary().some (skill) =>
      return this.correctSpelling(skill) == this.correctSpelling(@lctext) 

  toJSON: ->
    type: this.skillType() 
    name: @text

  skillCost: ->
   return 50 if @lctext == "+st" 
   return 40 if @lctext == "+ag"
   return 30 if @lctext == "+av"
   return 30 if @lctext == "+mv"
   return 30 if this.isDouble()
   return 20 if this.isNormal()
   return 30

  addStat: (stat) ->
    move_cell = @player.row.find("td.#{stat}")
    return unless move_cell.length > 0
    if move_cell.hasClass("first-stat")
      move_cell.addClass("second-stat") unless move_cell.hasClass("second-stat")
    else
      move_cell.addClass("first-stat")
    move_cell.text(move_cell.text()*1 + 1)

  removeStat: (stat) ->
    move_cell = @player.row.find("td.#{stat}")
    return unless move_cell.length > 0
    if move_cell.hasClass("second-stat")
      move_cell.removeClass("second-stat")
    else
      move_cell.removeClass("first-stat")
    move_cell.text(move_cell.text()*1 - 1)    

  addTo: (target) ->
    label_obj = $(this.output())
    $(target).append(label_obj)

    if @lctext.match(/\+(\w*)/)
      this.addStat(@lctext.match(/\+(\w*)/)[1]) 

    this.addCost()

    label_obj.on "mouseenter", ->
      $(this).find("span.remove-skill").stop().animate(width: "18px")
    label_obj.on "mouseleave", ->
      $(this).find("span.remove-skill").stop().animate(width: "0px")
    label_obj.on "click", ".remove-skill", (e) =>
      this.removeSelf()
      e.stopPropagation()

    return label_obj

  recolor: -> 
    $(this.label).attr("class", "")
    $(this.label).addClass("label #{this.displayClass()}")

  addCost: ->
    @player.team.updateTV(this.skillCost())
    cost_cell = @player.row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 + this.skillCost()) + "k" )

  removeCost: ->
    @player.team.updateTV(0 - this.skillCost())
    cost_cell = @player.row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 - this.skillCost()) + "k" )

  removeSelf: ->
    if @lctext.match(/\+(\w*)/)
      this.removeStat(@lctext.match(/\+(\w*)/)[1]) 
    @player.addedSkills.remove(this)
    this.removeCost()
    @label.remove() 

  skillType: -> 
    return "default" if this.isExtraordinary()
    return "normal" if this.isNormal()
    return "double" if this.isDouble() 
    return "mv" if @lctext == "+mv"
    return "av" if @lctext == "+av"
    return "ag" if @lctext  == "+ag"
    return "st" if @lctext  == "+st"    
  
  displayClass: ->
    switch this.skillType()
      when "default" then "label"
      when "normal"  then "label-info"
      when "double"  then "label-success"
      when "mv"      then "label-inverse"
      when "av"      then "label-inverse"
      when "ag"      then "label-warning"
      when "st"      then "label-important"

  correctSpelling: (text) ->
    return text.toLowerCase().replace(" ", "").replace("-", "")

  displayText: ->
    returned_skills = (skill for skill in Skill.all() when this.correctSpelling(skill) is this.correctSpelling(@lctext))
    if returned_skills.length > 0
      returned_skills[0]
    else
      @text

  output: ->
    return "<span class='label #{this.displayClass()}'>#{this.displayText()} <span class=remove-skill> &nbsp; | &times</span></span>"

this.Skill = Skill
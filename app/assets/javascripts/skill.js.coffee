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
      return skill.toLowerCase() == @lctext    
  isDouble: ->
    @player.doubleSkills().some (skill) =>
      return skill.toLowerCase() == @lctext 
  isExtraordinary: ->
    Skill.extraordinary().some (skill) =>
      return skill.toLowerCase() == @lctext 

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
    move_cell.text(move_cell.text()*1 + 1)

  removeStat: (stat) ->
    move_cell = @player.row.find("td.#{stat}")
    return unless move_cell.length > 0
    move_cell.text(move_cell.text()*1 - 1)    

  addTo: (target) ->
    label_obj = $(this.output())
    $(target).append(label_obj)

    if @lctext.match(/\+(\w*)/)
      this.addStat(@lctext.match(/\+(\w*)/)[1]) 

    cost_cell = @player.row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 + this.skillCost()) + "k" )

    label_obj.on "mouseenter", ->
      $(this).find("span.remove-skill").animate(width: "18px")
    label_obj.on "mouseleave", ->
      $(this).find("span.remove-skill").animate(width: "0px")
    label_obj.on "click", ".remove-skill", (e) =>
      this.removeSelf()
      e.stopPropagation()

    return label_obj

  removeSelf: ->
    if @lctext.match(/\+(\w*)/)
      this.removeStat(@lctext.match(/\+(\w*)/)[1]) 
    
    cost_cell = @player.row.find("td.cost")
    cost = cost_cell.text().replace("k", "")
    cost_cell.text((cost*1 - this.skillCost()) + "k" )
    
    @label.remove() 

  displayClass: ->
    return "label" if this.isExtraordinary()
    return "label-info" if this.isNormal()
    return "label-success" if this.isDouble() 
    return "label-inverse" if @lctext == "+mv" or @lctext == "+av"
    return "label-warning" if @lctext  == "+ag"
    return "label-important" if @lctext  == "+st"

  displayText: ->
    returned_skills = (skill for skill in Skill.all() when skill.toLowerCase() is @lctext)
    if returned_skills.length > 0
      returned_skills[0]
    else
      @text

  output: ->
    return "<span class='label #{this.displayClass()}'>#{this.displayText()} <span class=remove-skill> &nbsp; | &times</span></span>"

$.Skill = Skill
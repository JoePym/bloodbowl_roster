#= require jasmine-jquery

describe "Player",  ->
  beforeEach ->
    loadFixtures('amazons.html');
    @row = $('tr.player:first')
    @amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
    @blitzer = new Player(@amazons, @row)

  it 'should be defined', ->
    expect(Player).toBeDefined()

  it 'should correctly initialize a player', ->
    creator = ->
      amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
      blitzer = new Player(amazons, $('tr.player:first'))
    expect(creator).not.toThrow()
    expect(@blitzer).toBeDefined()
    expect(@row).toBeDefined()
    expect(@amazons).toBeDefined()

  describe "when it is successfully initiated", ->

    it "should have the correct default values for the other tests to be valid", ->
      tv = $("tr.teamValue td.tv").text()
      expect(tv).toEqual("970k")
      expect(@row.find("td.ma").text()).toEqual("6")
      expect(@row.find("td.st").text()).toEqual("3")
      expect(@row.find("td.ag").text()).toEqual("3")
      expect(@row.find("td.av").text()).toEqual("7")
      skills = @row.find(".defaultSkills span")
      skill_text = ""
      skills.each (index, skill) =>
        skill_text += $(skill).text().trim() + " "
      expect(skill_text).toEqual("Block Dodge ")

  	it "should be able to remove the position",  ->
      @blitzer.removePosition()
      expect(@row.find("td.ma").text()).toEqual("0")
      expect(@row.find("td.st").text()).toEqual("0")
      expect(@row.find("td.ag").text()).toEqual("0")
      expect(@row.find("td.av").text()).toEqual("0")
      new_tv = $("tr.teamValue td.tv").text()
      expect(new_tv).toEqual("880k")
      new_skills = @row.find(".defaultSkills span")
      new_skill_text = ""
      new_skills.each (index, skill) =>
        new_skill_text += $(skill).text().trim() + " "
      expect(new_skill_text).toEqual("")

    it "should be able to add a new position", ->
      super_linewoman_json = {"ag":4,"av":6,"cost":50, "default_skills":["Dodge"],"double_skills":["strength","agility"],"journeyman_position":true,"maximum":16,"mv":5,"name":"Linewoman","normal_skills":["general"],"roster_id":1,"st":2}
      @blitzer.removePosition()
      @blitzer.addPosition(super_linewoman_json)
      expect(@row.find("td.ma").text()).toEqual("5")
      expect(@row.find("td.st").text()).toEqual("2")
      expect(@row.find("td.ag").text()).toEqual("4")
      expect(@row.find("td.av").text()).toEqual("6")
      new_tv = $("tr.teamValue td.tv").text()
      expect(new_tv).toEqual("930k")
      new_skills = @row.find(".defaultSkills span")
      new_skill_text = ""
      new_skills.each (index, skill) =>
        new_skill_text += $(skill).text().trim() + " "
      expect(new_skill_text).toEqual("Dodge ")      





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

  	it "should be able to remove the position",  ->
      @blitzer.removePosition()
      expect(@row.find("td.ma").text()).toEqual("0")
      expect(@row.find("td.st").text()).toEqual("0")
      expect(@row.find("td.ag").text()).toEqual("0")
      expect(@row.find("td.av").text()).toEqual("0")


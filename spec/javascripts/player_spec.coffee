#= require jasmine-jquery

describe "Player",  ->
  beforeEach ->
    loadFixtures('amazons.html');

  it 'should be defined', ->
    expect(Player).toBeDefined()

  it 'should correctly initialize a player', ->
    creator = ->
      amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
      blitzer = new Player(amazons, ('tr.player:first')[0])
    expect(creator).not.toThrow()

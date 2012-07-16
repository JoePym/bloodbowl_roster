#= require jasmine-jquery

describe "Team",  ->
  beforeEach ->
    loadFixtures('amazons.html');
    @amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
  it 'should be defined', ->
    expect(Team).toBeDefined()

  it 'should correctly initialize a team', ->
    creator = ->
      amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
    expect(creator).not.toThrow()

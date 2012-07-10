#= require jasmine-jquery

describe "Team",  ->
  beforeEach ->
    loadFixtures('amazons.html');

  it 'should be defined', ->
    expect(Team).toBeDefined()

  it 'should correctly initialize a team', ->
    creator = ->
      amazons = new Team($("table.team"), $(".teamDetails table"), $(".teamName"))
    expect(creator).not.toThrow()

  
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "creating Chaos"
chaos = Roster.create(:name => "Chaos", :reroll_cost => 60)

puts "adding positionals to Chaos"
beastman = chaos.positions.create(:name => "Beastman",
  :mv => 6, :st => 3, :ag => 3, :av => 8,
  :default_skills => ["Horns"], :cost => 60, :journeyman_position => true)
cw = chaos.positions.create(:name => "Chaos Warrior",
  :mv => 5, :st => 4, :ag => 3, :av => 9,
  :default_skills => [], :cost => 100)
mino = chaos.positions.create(:name => "Minotaur",
  :mv => 5, :st => 5, :ag => 2, :av => 9, 
  :default_skills => ["Frenzy", "Mighty Blow", "Thick Skull", "Horns", "Loner", "Wild Animal"], :cost => 150)

puts "Creating sample team"
team = Team.create(:name => "Chaos Allstars")
team.roster = chaos
team.save!
team.players.create(:name => "Grashnak", :position => mino, :number => 1)
4.times do |i|
  team.players.create(:name => "CW #{i}", :position => cw, :number => 2 + i)
end
10.times do |i|
  team.players.create(:name => "Beastman #{i}", :position => beastman, :number => 7 + i)
end

class Roster < ActiveRecord::Base
  attr_accessible :name, :reroll_cost, :logo_path, :allow_apo

  has_many :positions
  has_many :teams
end

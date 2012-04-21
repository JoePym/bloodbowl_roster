class Roster < ActiveRecord::Base
  attr_accessible :name, :reroll_cost

  has_many :positions
end

class Roster < ActiveRecord::Base
  attr_accessible :name, :reroll_cost, :logo_path

  has_many :positions
end

class Team < ActiveRecord::Base
  attr_accessible :assistant_coaches, :cheerleaders, :name, :rerolls

  belongs_to :roster
  has_many :players
end

class Team < ActiveRecord::Base
  attr_accessible :assistant_coaches, :cheerleaders, :name, :rerolls, :tv, :apo, :logo_path

  belongs_to :roster
  has_many :players
end

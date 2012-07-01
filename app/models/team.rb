class Team < ActiveRecord::Base
  attr_accessible :assistant_coaches, :cheerleaders, :name, :rerolls, :tv, :apo, :logo_path, :fanfactor, :gold, :roster_id

  belongs_to :roster
  has_many :players

  def to_param
    self.roster.name.downcase.gsub(" ", "_")
  end
end

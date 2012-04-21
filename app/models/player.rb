class Player < ActiveRecord::Base
  attr_accessible :name, :number, :position, :skills
  serialize :skills

  belongs_to :team
  belongs_to :position
end

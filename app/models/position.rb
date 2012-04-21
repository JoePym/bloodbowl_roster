class Position < ActiveRecord::Base
  attr_accessible :ag, :av, :cost, :default_skills, :mv, :name, :st, :journeyman_position

  serialize :default_skills
end

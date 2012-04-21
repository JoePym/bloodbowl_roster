class Position < ActiveRecord::Base
  attr_accessible :ag, :av, :cost, :maximum, :default_skills, :mv, :name, :st, :journeyman_position, :normal_skills, :double_skills

  serialize :default_skills
  serialize :normal_skills
  serialize :double_skills


end

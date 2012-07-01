class Player < ActiveRecord::Base
  attr_accessor :st, :ag, :mv, :av, :playerNum, :cost
  attr_accessible :name, :number, :position, :skills, :st, :ag, :mv, :av, :position_id, :cost, :playerNum
  serialize :skills

  belongs_to :team
  belongs_to :position

end

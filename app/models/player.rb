class Player < ActiveRecord::Base
  attr_accessor :st, :ag, :ma, :av, :playerNum, :cost, :mv
  attr_accessible :name, :number, :position, :skills, :st, :ag, :mv, :ma, :av, :position_id, :cost, :playerNum
  serialize :skills

  belongs_to :team
  belongs_to :position

end

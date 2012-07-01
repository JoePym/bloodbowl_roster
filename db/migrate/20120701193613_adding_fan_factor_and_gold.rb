class AddingFanFactorAndGold < ActiveRecord::Migration
  def up
  	add_column :teams, :fanfactor, :integer
  	add_column :teams, :gold, :integer
  end

  def down
  	remove_column :teams, :fanfactor
  	remove_column :teams, :gold
  end
end

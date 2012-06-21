class AddingRostersWithoutApos < ActiveRecord::Migration
  def up
    add_column :rosters, :allow_apo, :boolean, :default => true, :null => false
  end

  def down
    remove_column :rosters, :allow_apo
  end
end

class AddingTeamValueToTeams < ActiveRecord::Migration
  def up
    add_column :teams, :apo, :boolean, :default => false, :null => false
    add_column :teams, :tv, :integer
    add_column :rosters, :logo_path, :string
  end

  def down
    remove_column :teams, :apo
    remove_column :teams, :tv
    remove_column :rosters, :logo_path
  end
end

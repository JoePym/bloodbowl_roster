class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :rerolls
      t.integer :assistant_coaches
      t.integer :cheerleaders
      t.integer :roster_id

      t.timestamps
    end
  end
end

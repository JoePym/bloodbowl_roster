class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.string :name
      t.integer :reroll_cost

      t.timestamps
    end
  end
end

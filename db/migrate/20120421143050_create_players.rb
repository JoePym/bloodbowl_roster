class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.integer :position_id
      t.text :skills
      t.integer :team_id
      t.integer :number
      t.timestamps
    end
  end
end

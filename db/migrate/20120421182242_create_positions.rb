class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.integer :st
      t.integer :ag
      t.integer :mv
      t.integer :av
      t.integer :cost
      t.boolean :journeyman_position, :default => false, :null => false
      t.text :normal_skills
      t.text :double_skills
      t.integer :roster_id
      t.integer :maximum
      t.text :default_skills

      t.timestamps
    end
  end
end

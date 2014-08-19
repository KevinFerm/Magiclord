class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.string :name
      t.integer :location
      t.integer :size
      t.integer :explored
      t.integer :amount_puzzle_room
      t.boolean :boss
      t.integer :boss_id
      t.integer :amount_loot_room
      t.string :current_room
      t.string :typ
      t.integer :max_amount_monster
      t.integer :max_amount_boss
      t.timestamps
    end
  end
end

class CreateWorldMaterials < ActiveRecord::Migration
  def change
    create_table :world_materials do |t|
      t.string :name
      t.string :typ
      t.integer :amount
      t.integer :loot_chance
      t.integer :find_chance
      t.integer :location
      t.integer :weight
      t.integer :explored
      t.timestamps
    end
  end
end

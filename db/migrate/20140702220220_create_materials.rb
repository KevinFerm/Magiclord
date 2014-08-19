class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :rarity
      t.string :typ
      t.integer :size
      t.integer :quanity
      t.string :biome
      t.string :info
      t.string :param

      t.timestamps
    end
  end
end

class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
<<<<<<< Updated upstream
      t.integer :rarity
      t.string :typ
      t.integer :size
      t.integer :quanity
      t.string :biome
=======
      t.integer :rate
      t.string :type
>>>>>>> Stashed changes
      t.string :info
      t.string :param

      t.timestamps
    end
  end
end

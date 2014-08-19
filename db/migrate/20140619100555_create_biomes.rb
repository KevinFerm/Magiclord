class CreateBiomes < ActiveRecord::Migration
  def change
    create_table :biomes do |t|
      t.string :title
      t.integer :temp
      t.integer :lost_chance
      t.boolean :indoors, default: false
      t.timestamps
    end
  end
end

class CreateBiomes < ActiveRecord::Migration
  def change
    create_table :biomes do |t|
      t.string :title
      t.integer :temp
      t.boolean :indoors, default: false
      t.timestamps
    end
  end
end

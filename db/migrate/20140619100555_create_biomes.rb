class CreateBiomes < ActiveRecord::Migration
  def change
    create_table :biomes do |t|
      t.string :title

      t.timestamps
    end
  end
end

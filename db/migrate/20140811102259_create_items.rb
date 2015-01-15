class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :size
      t.integer :weight
      t.references :inventory, index: true
      t.string :material
      t.string :equip
      t.boolean :blueprint
      t.timestamps
    end
  end
end

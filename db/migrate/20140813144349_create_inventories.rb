class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :size
      t.integer :max_weight
      t.references :item, index: true
      t.references :character, index: true
      t.timestamps
    end
  end
end

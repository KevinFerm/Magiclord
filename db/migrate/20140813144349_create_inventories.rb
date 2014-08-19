class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :size
      t.integer :max_weight
      t.integer :item_id
      t.timestamps
    end
  end
end

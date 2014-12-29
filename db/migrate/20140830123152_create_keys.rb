class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :splint1
      t.integer :splint2
      t.integer :splint3
      t.integer :splint4
      t.integer :splint5
      t.integer :splint6
      t.integer :quality
      t.references :item, index: true
      t.timestamps
    end
  end
end

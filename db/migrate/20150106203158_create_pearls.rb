class CreatePearls < ActiveRecord::Migration
  def change
    create_table :pearls do |t|
      t.string :title
      t.string :parts
      t.string :type
      t.integer :ep
      t.integer :curr_ep
      t.string :effect
      t.string :desc
      t.references :item, index: true

      t.timestamps
    end
  end
end

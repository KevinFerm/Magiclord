class CreateCaves < ActiveRecord::Migration
  def change
    create_table :caves do |t|
      t.string :name
      t.integer :location
      t.integer :size
      t.integer :explored
      t.string :typ
      t.timestamps
    end
  end
end

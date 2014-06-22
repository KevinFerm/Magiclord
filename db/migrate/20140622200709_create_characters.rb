class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :Name
      t.integer :Strength

      t.timestamps
    end
  end
end

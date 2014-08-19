class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :FirstName
      t.string :Age
      t.string :Profession, :default => 0
      t.string :Race
      t.string :LastName
      t.string :Class
      t.string :Equipment, :default => 0
      t.integer :Status, :default => 1
      t.integer :Strength, :default => 10
      t.integer :Agility, :default => 10
      t.integer :Intelligence, :default => 10
      t.integer :Stamina, :default => 10
      t.integer :Curr_Stamina, :default => 10
      t.integer :Curr_Hp, :default => 10
      t.integer :location
      t.references :user, index: true

      t.timestamps
    end
  end
end

class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :FirstName
      t.string :Age
      t.string :Primary_Profession
      t.string :Secondary_Profession
      t.string :Race
      t.string :LastName
      t.string :Class
      t.integer :Status, :default => 1
      t.integer :Strength, :default => 10
      t.integer :Agility, :default => 10
      t.integer :Intelligence, :default => 10
      t.integer :Stamina, :default => 10
      t.integer :Curr_Stamina, :default => 10
      t.integer :Curr_Hp, :default => 10
      t.string :effect
      t.integer :location
      t.references :user, index: true

      t.timestamps
    end
  end
end

class Npcs < ActiveRecord::Migration
  def change
    create_table :npcs do |t|
      t.string :FirstName
      t.string :LastName
      t.string :Age
      t.string :Profession
      t.string :Race
      t.string :Class
      t.string :Equipment
      t.integer :Strength
      t.integer :Agility
      t.integer :Intelligence
      t.integer :Stamina
      t.integer :Curr_Stamina
      t.integer :Curr_Hp

      t.timestamps
    end
  end
end

class Races < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :race
      t.string :desc
      t.string :a
    end
  end
end

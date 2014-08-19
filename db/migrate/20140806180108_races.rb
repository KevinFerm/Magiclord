class Races < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :race
    end
  end
end

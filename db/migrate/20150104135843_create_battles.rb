class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :contestant
      t.integer :phase
      t.integer :location

      t.timestamps
    end
  end
end

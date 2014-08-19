class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :title
      t.string :biome
      t.integer :size
      t.string :connect
      t.string :compass
      t.string :contain
      t.string :finder
      t.string :owner
      t.boolean :hidden
      t.boolean :lock

      t.timestamps
    end
  end
end

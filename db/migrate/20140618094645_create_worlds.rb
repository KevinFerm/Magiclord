class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :title
      t.string :biome
      t.integer :size
      t.integer :size_fix
      t.string :connect
      t.string :compass
      t.string :finder
      t.string :owner
      t.boolean :hidden
      t.boolean :lock
      t.boolean :allow_pvp
      t.boolean :allow_gathering
      t.boolean :allow_hunting

      t.timestamps
    end
  end
end

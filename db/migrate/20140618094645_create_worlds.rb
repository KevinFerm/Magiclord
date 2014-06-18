class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :title
      t.integer :size
      t.string :connect
      t.boolean :hidden
      t.boolean :lock

      t.timestamps
    end
  end
end

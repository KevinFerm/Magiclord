class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.string :name
      t.string :type
      t.string :owner
      t.string :lock
      t.timestamps
    end
  end
end

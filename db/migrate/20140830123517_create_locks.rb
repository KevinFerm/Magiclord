class CreateLocks < ActiveRecord::Migration
  def change
    create_table :locks do |t|
      t.integer :splint1
      t.integer :splint2
      t.integer :splint3
      t.integer :splint4
      t.integer :splint5
      t.integer :splint6
      t.integer :quality
      t.timestamps
    end
  end
end

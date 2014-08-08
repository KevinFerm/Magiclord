class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :rate
      t.string :type
      t.string :info
      t.string :param

      t.timestamps
    end
  end
end

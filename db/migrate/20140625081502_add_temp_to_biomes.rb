class AddTempToBiomes < ActiveRecord::Migration
  def change
    add_column :biomes, :temp, :integer
  end
end

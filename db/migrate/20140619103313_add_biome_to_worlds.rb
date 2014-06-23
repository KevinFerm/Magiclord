class AddBiomeToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :biome, :biome
  end
end

class AddBiomeToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :biome, :string
  end
end

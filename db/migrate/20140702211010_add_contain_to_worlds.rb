class AddContainToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :contain, :string
  end
end

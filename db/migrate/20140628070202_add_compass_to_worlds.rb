class AddCompassToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :compass, :string
  end
end

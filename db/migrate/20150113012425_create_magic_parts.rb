class CreateMagicParts < ActiveRecord::Migration
  def change
    create_table :magic_parts do |t|
      t.string :title
      t.string :type
      t.string :effect

      t.timestamps
    end
  end
end

class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :title
      t.text :msg
      t.integer :bind

      t.timestamps
    end
  end
end

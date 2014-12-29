class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :npc, index: true
      t.integer :sell
      t.integer :sell_quantity
      t.integer :buy
      t.integer :buy_quantity
      t.timestamps
    end
  end
end

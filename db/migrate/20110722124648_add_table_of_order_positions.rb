class AddTableOfOrderPositions < ActiveRecord::Migration
  def up
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :count

      t.timestamps
    end
  end

  def down
    drop_table :order_items
  end
end

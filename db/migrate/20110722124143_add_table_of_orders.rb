class AddTableOfOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :order_state_type_id

      t.timestamps
    end
  end

  def down
    drop_table :orders
  end
end

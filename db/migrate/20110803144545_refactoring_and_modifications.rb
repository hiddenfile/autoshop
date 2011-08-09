class RefactoringAndModifications < ActiveRecord::Migration
  def up
    drop_table :prices
    remove_column :products, :price_id

    create_table :discounts
    add_column :discounts, :value, :float

    add_column :products, :discount_id, :integer
    add_column :products, :price, :float

    remove_column :order_items, :product_id
    add_column :order_items, :product_name, :string
    add_column :order_items, :product_price, :float
    add_column :order_items, :product_discount ,:float
  end

  def down
    create_table :prices



    add_column :products, :price_id, :integer

    drop_table :discounts

    remove_column :products, :discount_id
    remove_column :products, :price

    add_column :order_items, :product_id, :integer
    remove_column :order_items, :product_name
    remove_column :order_items, :product_price
    remove_column :order_items, :product_discount
  end
end

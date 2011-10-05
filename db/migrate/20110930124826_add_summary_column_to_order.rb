class AddSummaryColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :summary, :float, :default => 0

    Order.all.each do |order|
      val = 0
      order.order_items.each {|order_item| val+=order_item.product_price * order_item.count}
      order.update_attribute(:summary, val)
    end
  end
end

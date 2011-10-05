class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :count, :numericality => true, :presence => true
  validates :order_id, :numericality => true, :presence => true , :if => Proc.new { |record| !record.new_record? }

  after_save :recalculate_summary
  before_destroy :recalculate_summary_on_del

  protected
   def recalculate_summary
     val=0
     self.order.order_items.each {|item| val += item.product_price * item.count }
     self.order.update_attribute(:summary, val)
   end

   def recalculate_summary_on_del
     self.order.update_attribute(:summary, self.order.summary - (self.count * self.product_price))
   end
end

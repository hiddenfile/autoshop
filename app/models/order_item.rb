class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order_id, :numericality => true, :presence => true , :if => Proc.new { |record| !record.new_record? }
  validates :product_name, :presence => true
  validates :product_price, :count, :presence => true, :numericality => true
end

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :order_id,:product_id,:count, :numericality => true, :presence => true
end

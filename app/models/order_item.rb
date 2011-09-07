class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :count, :numericality => true, :presence => true
  validates :order_id, :numericality => true, :presence => true , :if => Proc.new { |record| !record.new_record? }
end

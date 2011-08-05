class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user

  validates :order_state, :presence => true, :length => {:minimum => 4, :maximum => 300}
  validates :user_id, :numericality => true, :presence => true
end

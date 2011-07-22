class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user
  has_one :order_state_type
end

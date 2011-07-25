class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user
end

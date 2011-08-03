class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  belongs_to :user

  def self.order_states
    ['In process','Verified','Done']
  end
end

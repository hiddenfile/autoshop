class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items
  belongs_to :user

  def self.order_states
    ['In process', 'Verified', 'Done']
  end
  validates :order_state, :presence => true, :length => {:minimum => 4, :maximum => 30}
  validates :user_id, :numericality => true, :presence => true
end

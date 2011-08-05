class Product < ActiveRecord::Base
  belongs_to :company
  belongs_to :group
  has_many :photos, :as => :entity, :dependent => :destroy
  belongs_to :price
  has_many :order_items

  validates :title, :presence => true, :length => {:minimum => 3, :maximum => 300}
  validates :title, :length => {:minimum => 4, :maximum => 50}
  validates :company_id,:group_id, :numericality => true, :presence => true
end

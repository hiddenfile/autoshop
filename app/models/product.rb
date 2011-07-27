class Product < ActiveRecord::Base
  belongs_to :company
  belongs_to :group
  has_many :photos, :as => :entity, :dependent => :destroy
  belongs_to :price
  has_many :order_items
  validates :title, :presence => true
end

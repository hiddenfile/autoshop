class Product < ActiveRecord::Base
  belongs_to :company
  belongs_to :group
  has_many :photos, :as => :entity, :dependent => :destroy
  belongs_to :price
  validates :title, :presence => true


end

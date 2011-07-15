class Group < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :companies, :through => :products
  has_many :photos, :as => :entity, :dependent => :destroy
  validates :name, :presence => true
end

class Group < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :companies, :through => :products
end

class Company < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :groups, :through => :products
end

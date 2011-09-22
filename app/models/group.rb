class Group < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :companies, :through => :products, :uniq => true
  has_many :photos, :as => :entity, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :length => {:minimum => 4, :maximum => 50}
end

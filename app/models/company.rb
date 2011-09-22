class Company < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :groups, :through => :products, :uniq => true
  has_many :photos, :as => :entity, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :length => {:minimum => 3, :maximum => 50}
end

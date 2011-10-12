class Discount < ActiveRecord::Base
  has_many :users

  validates :value , :presence => true
end

class Discount < ActiveRecord::Base
  has_many :users

  validates :value , :presence => true, :numericality => { :greater_than => 0, :less_than_or_equal_to => 1.0 }
end

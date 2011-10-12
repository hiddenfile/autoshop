class Backcall < ActiveRecord::Base
  apply_simple_captcha

  belongs_to :product

  validates :content, :author, :presence => true
  validates :product_id, :presence => true, :numericality => true
end

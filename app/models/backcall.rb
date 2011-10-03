class Backcall < ActiveRecord::Base
  apply_simple_captcha

  belongs_to :product

  validates_presence_of :content, :author, :product_id
end

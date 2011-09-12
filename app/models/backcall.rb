class Backcall < ActiveRecord::Base
  apply_simple_captcha

  belongs_to :product
end

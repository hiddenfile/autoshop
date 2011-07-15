require 'test_helper'

class PriceTest < ActiveSupport::TestCase
  should validate_presence_of :price
  should belong_to :product
end

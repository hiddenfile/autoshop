require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should belong_to :group
  should belong_to :company
  should belong_to :price

  should validate_presence_of :description
  should validate_presence_of :title
end

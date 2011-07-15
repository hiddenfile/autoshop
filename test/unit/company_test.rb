require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
   should validate_presence_of :name

   should have_many (:products)#.dependent(:destroy)
   should have_many (:groups)#.through(:products)
end

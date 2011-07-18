require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  test "password_validations" do
    @admin = Admin.new
    assert !post.save
  end


end

require 'spec_helper'

describe User, 'accessible attributes' do
  before do
    @user = Factory(:user)
  end

  it 'should have attr_accessible' do
     lambda { @user.update_attributes(:email => 'a@b.com',
                                      :password => "10237102sd",
                                      :password_confirmation => "10237102sd",
                                      :remember_me => true)}.should_not raise_error
  end
end
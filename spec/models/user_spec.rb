require 'spec_helper'

describe User, 'accessible attributes' do
  before do
    @user = Factory(:user)
  end

  it 'should have attr_accessible' do
     lambda { @user.update_attributes(:email => 'test@mail.com',
                                      :password => "qwerty",
                                      :password_confirmation => "qwerty",
                                      :remember_me => true)}.should_not raise_error
  end
end
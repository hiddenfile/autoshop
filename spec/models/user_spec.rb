require 'spec_helper'

describe User, 'accessible attributes' do
  before do
    @user = Factory(:user)
  end

  it "is invalid with password confirmation failed" do
    @user.password = "123456789"
    @user.password_confirmation = "987654321"
    @user.should_not be_valid
  end

  it "is invalid with short password" do
    @user.password = "123345"
    @user.should_not be_valid
  end

  it "is invalid with bad email value" do
    @user.email = "asdjkfasdjklfasdf"
    @user.should_not be_valid
  end

  it "is invalid with nil email value" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "is invalid with nil password value" do
    @user.password = nil
    @user.should_not be_valid
  end

  it "is valid" do
    @user.should be_valid
  end

  it "should has_many :orders, :dependent => :destroy" do
    g = User.reflect_on_association(:orders)
    g.macro.should == :has_many
    g.options[:dependent].should == :destroy
  end
end
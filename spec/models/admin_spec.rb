require 'spec_helper'

describe Admin do
  before do
    @admin = Admin.new(:password => "111222333", :email => "1@file.com")
  end

  it "is invalid with password confirmation failed" do
    @admin.password = "123456789"
    @admin.password_confirmation = "987654321"
    @admin.should_not be_valid
  end

  it "is invalid with short password" do
    @admin.password = "123"
    @admin.should_not be_valid
  end

  it "is invalid with bad email value" do
    @admin.email = "asdjkfasdjklfasdf"
    @admin.should_not be_valid
  end

  it "is invalid with nil email value" do
    @admin.email = nil
    @admin.should_not be_valid
  end

  it "is invalid with nil password value" do
    @admin.password = nil
    @admin.should_not be_valid
  end

  it "is valid" do
    @admin.should be_valid
  end
end
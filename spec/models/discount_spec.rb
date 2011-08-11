require 'spec_helper'

describe Discount do
  it "should has_many :users" do
    g = Discount.reflect_on_association(:users)
    g.macro.should == :has_many
  end
end
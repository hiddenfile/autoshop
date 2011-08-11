require 'spec_helper'

describe Discount do
  it "should has_many :products" do
    g = Discount.reflect_on_association(:products)
    g.macro.should == :has_many
  end
end
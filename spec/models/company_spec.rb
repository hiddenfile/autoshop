require "spec_helper"

describe Company do

  it "should have many products" do
    g = Company.reflect_on_association(:products)
    g.macro.should == :has_one
  end



end
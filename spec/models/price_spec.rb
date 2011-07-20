require 'spec_helper'

describe Price do
  it "should belongs_to :product" do
    g = Price.reflect_on_association(:product)
    g.macro.should == :belongs_to
  end
end
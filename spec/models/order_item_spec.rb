require "spec_helper"

describe OrderItem do
  before do
    @order_item = Factory.build(:order_item)
  end

  it "should be invalid with nil order_id" do
    @order_item.order_id = nil
    lambda{@order_item.save!}.should raise_error
  end

  it "should be invalid with nil count" do
    @order_item.count = nil
    lambda{@order_item.save!}.should raise_error
  end

  it ":user_id should be the number" do
    @order_item.order_id = "a"
    @order_item.should_not be_valid
  end

  it ":user_id should be the number" do
    @order_item.count = "a"
    @order_item.should_not be_valid
  end

  it "should  belongs_to :order" do
    g = OrderItem.reflect_on_association(:order)
    g.macro.should == :belongs_to
  end

  it "should  belongs_to :product" do
    g = OrderItem.reflect_on_association(:product)
    g.macro.should == :belongs_to
  end
end
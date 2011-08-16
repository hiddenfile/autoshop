require "spec_helper"

describe Order do
  before do
    @order = Factory.build(:order)
  end

  it "should be invalid with nil order_state" do
    @order.order_state = nil
    lambda{@order.save!}.should raise_error
  end

  it "should be invalid with nil user_id" do
    @order.user_id = nil
    lambda{@order.save!}.should raise_error
  end

  it "is invalid with short name" do
    @order.order_state = "1234"
    @order.should_not be_valid
  end

  it ":user_id should be the number" do
    @order.user_id = "a"
    @order.should_not be_valid
  end

  it "should  belongs_to :user" do
    g = Order.reflect_on_association(:user)
    g.macro.should == :belongs_to
  end

  it "should  has_many :order_items, :dependent => :destroy" do
    g = Order.reflect_on_association(:order_items)
    g.macro.should == :has_many
    g.options[:dependent].should == :destroy
  end
end
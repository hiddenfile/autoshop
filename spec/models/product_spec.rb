require 'spec_helper'

describe Product do
  before do
    @product = Factory.build(:product)
  end

  it "should belongs_to :company" do
    g = Product.reflect_on_association(:company)
    g.macro.should == :belongs_to
  end

  it "should belongs_to :group" do
    g = Product.reflect_on_association(:group)
    g.macro.should == :belongs_to
  end

  it "should has_many :photos, :as => :entity, :dependent => :destroy" do
    g = Product.reflect_on_association(:photos)
    g.macro.should == :has_many
    g.options[:as].should == :entity
    g.options[:dependent].should == :destroy
  end

  it "should has_many :order_items" do
    g = Product.reflect_on_association(:order_items)
    g.macro.should == :has_many
  end

  it "is invalid with short title" do
    @product.title = "12"
    @product.should_not be_valid
  end

  it "should validates :title, :presence => true" do
    @product.title = nil
    lambda{@product.save!}.should raise_error
  end

    it "should be invalid with nil order_id" do
    @product.company_id = nil
    lambda{@product.save!}.should raise_error
  end

  it "should be invalid with nil count" do
    @product.group_id = nil
    lambda{@product.save!}.should raise_error
  end

  it ":user_id should be the number" do
    @product.company_id = "a"
    @product.should_not be_valid
  end

  it ":user_id should be the number" do
    @product.group_id = "a"
    @product.should_not be_valid
  end
end
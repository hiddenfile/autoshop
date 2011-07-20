require 'spec_helper'

describe Product do
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

  it "should belongs_to :price" do
    g = Product.reflect_on_association(:price)
    g.macro.should == :belongs_to
  end

  it "should validates :title, :presence => true" do
    @product = Factory(:product)
    @product.title = nil
    lambda{@product.save!}.should raise_error
  end
end
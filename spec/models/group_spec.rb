require "spec_helper"

describe Group do
  before do
    @group = Factory.build(:group)
  end

  it "should  has_many :products, :dependent => :destroy" do
    g = Group.reflect_on_association(:products)
    g.macro.should == :has_many
    g.options[:dependent].should == :destroy
  end

  it "should has_many :companies, :throught => :products" do
    g = Group.reflect_on_association(:companies)
    g.macro.should == :has_many
    g.options[:through].should == :products
  end

  it "should has_many :photos, :as => :entity, :dependent => :destroy" do
    g = Group.reflect_on_association(:photos)
    g.macro.should == :has_many
    g.options[:as].should == :entity
    g.options[:dependent].should == :destroy
  end

  it "should be invalid with nil name" do
    @group.name = nil
    lambda{@group.save!}.should raise_error
  end
end

require "spec_helper"

describe Company do
  before do
    @company = Factory.build(:company)
  end

  it "should have name" do
    @company.name = nil
    lambda{@company.save!}.should raise_error
  end

  it "should has_many :products, :dependent => :destroy" do
    g = Company.reflect_on_association(:products)
    g.macro.should == :has_many
    g.options[:dependent].should == :destroy
  end

  it "should has_many :groups, :through => :products" do
    g = Company.reflect_on_association(:groups)
    g.macro.should == :has_many
    g.options[:through].should == :products
  end

  it "should has_many :photos, :as => :entity, :dependent => :destroy" do
    g = Company.reflect_on_association(:photos)
    g.macro.should == :has_many
    g.options[:as].should == :entity
    g.options[:dependent].should == :destroy
  end
end
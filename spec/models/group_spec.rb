require "spec_helper"

describe Group do
  before do
    @group = Factory.build(:group)
  end

  it "should be invalid with nil name" do
    @group.name = nil
    lambda{@group.save!}.should raise_error
  end

  it "is invalid with short name" do
    @group.name = "123"
    @group.should_not be_valid
  end

  it "name already use" do
    @group.save
    @group_1 = Factory.build(:group)
    @group_1.name = "123456789"
    @group_1.should_not be_valid
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
end

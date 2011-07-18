require "spec_helper"

describe Company do
  before do
    @company = Company.new(:name => "test_company")
  end

  it "should have many products" do
    g = Company.reflect_on_association(:products)
    g.macro.should == :has_many
  end

  it "should destroy all products on self destroy" do
    Product.delete_all
    3.times do |i|
      @company.products.build(:title => "product - #{i}")
    end
    lambda{@company.save!}.should_not raise_error
    Product.all.should_not == []
    @company.destroy
    Product.all.should == []
  end

  it "should have many groups" do
    g = Company.reflect_on_association(:groups)
    g.macro.should == :has_many
  end

#  it "should have has_many :groups, :throught => :products relation" do
#    Group.delete_all
#    ctr = 0
#    3.times do |i|
#      @company.group.build(:name => "group - #{i}")
#    end
#    lambda{@company.save!}.should_not raise_error
#    Group.all.size.should == 3
#  end

end
require 'spec_helper'

describe Photo do
  it "should  belongs_to :entity, :polymorphic => true" do
    g = Photo.reflect_on_association(:entity)
    g.macro.should == :belongs_to
    g.options[:polymorphic].should be_true
  end

  it "should have correctly save of test picture" do
   @photo = Factory(:photo)
   @photo.should_not be_nil

    #need to test saving files
  end
end


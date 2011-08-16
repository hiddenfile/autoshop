require 'spec_helper'

describe Photo do
  before do
    @photo = Factory.build(:photo)
  end

  it "is invalid with short name" do
    @photo.photo_file_name = ""
    @photo.should_not be_valid
  end

  it "photo size should be less than 1Mb" do
    @photo.photo_file_size.should < 1.megabytes
  end

  it "should  belongs_to :entity, :polymorphic => true" do
    g = Photo.reflect_on_association(:entity)
    g.macro.should == :belongs_to
    g.options[:polymorphic].should be_true
  end

  it "should have correctly save of test picture" do
   @photo.should_not be_nil
   #need to test saving files
  end
end


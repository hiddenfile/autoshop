require 'spec_helper'

describe Photo do
  it "should  belongs_to :entity, :polymorphic => true" do
    g = Photo.reflect_on_association(:entity)
    g.macro.should == :belongs_to
    g.options[:polymorphic].should be_true
  end

#  it "should have has_attached_file with params" do
#   # @photo = Photo.new(:photo => File.new(Rails.root + 'spec/fixtures/images/rails.png'))
#    #lambda{@photo.save!}.should_not
#
#    #should has_attached_file(:photo)
#
#  end
end
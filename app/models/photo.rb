class Photo < ActiveRecord::Base

  has_attached_file :photo, :styles => {:medium => "300x300", :thumb => "100x100"}

  #has_attached_file :photo, :whiny => false , :styles=>{ :thumbnail=>"124x124"}, :path => "#{Rails.root}/store/:normalized_file_name.:extension"

  belongs_to :entity, :polymorphic => true

 # validates_length_of :photo_file_name, :maximum => 255

end

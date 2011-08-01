class Photo < ActiveRecord::Base

  has_attached_file :photo, :styles => {:medium => "178x178", :thumb => "78x78#"},
                    :path => "#{Rails.root}/app/assets/images/photos/:id/:style/:id-:style.:extension",
                    :url => "photos/:id/:style/:id-:style.:extension"


  belongs_to :entity, :polymorphic => true

 # validates_length_of :photo_file_name, :maximum => 255

end

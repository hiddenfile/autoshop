class Photo < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true

  has_attached_file :photo, :styles => {:medium => ["178x178",:jpg], :thumb => ["78x78#",:jpg]},
                    :path => "#{Rails.root}/app/assets/images/photos/:id/:style/:id-:style.:extension",
                    :url => "photos/:id/:style/:id-:style.:extension"

  validates_attachment_size :photo, :less_than => 1.megabytes
  validates :photo_file_name, :length => {:minimum => 1, :maximum => 50}


end

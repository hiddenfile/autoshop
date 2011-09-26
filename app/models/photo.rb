class Photo < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true

  has_attached_file :photo, :styles => {:medium => ["420x420",:jpg], :thumb => ["128x128#",:jpg], :small => ["78x78#",:jpg]},
                    :path => "#{Rails.root}/app/assets/images/photos/:id/:style/:id-:style.:extension",
                    :url => "photos/:id/:style/:id-:style.:extension", :default_url => "/photos/noimage.png"

  validates_attachment_size :photo, :less_than => 1.megabytes
  validates :photo_file_name, :length => {:minimum => 1, :maximum => 50}


end

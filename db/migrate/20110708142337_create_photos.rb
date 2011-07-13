class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      t.integer :entity_id
      t.string :entity_type
      t.timestamps
    end
  end

  def down
     drop_table :photos
  end
end

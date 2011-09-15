class CreateCustomViews < ActiveRecord::Migration
  def change
    create_table :custom_views do |t|
      t.string :page_type
      t.text :page_content

      t.timestamps
    end
  end
end

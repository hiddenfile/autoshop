# coding: utf-8
class CreateCustomViews < ActiveRecord::Migration
  def change
    create_table :custom_views do |t|
      t.string :page_type
      t.text :page_content

      t.timestamps
    end
      contacts = CustomViews.new(:page_type => "Контакты", :page_content => "")
      contacts.save!
      faq = CustomViews.new(:page_type => "FAQ", :page_content => "")
      faq.save!
  end
end

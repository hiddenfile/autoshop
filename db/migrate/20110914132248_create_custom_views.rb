# coding: utf-8
class CreateCustomViews < ActiveRecord::Migration
  def change
    create_table :custom_views do |t|
      t.string :page_type
      t.string :page_name
      t.text :page_content

      t.timestamps
    end
      contacts = CustomViews.new(:page_type => "base", :page_name => "Контакты", :page_content => "")
      contacts.save!
      faq = CustomViews.new(:page_type => "base", :page_name => "FAQ", :page_content => "")
      faq.save!
  end
end

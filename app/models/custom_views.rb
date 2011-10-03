class CustomViews < ActiveRecord::Base
  validates_presence_of :page_type, :page_name
  validates_inclusion_of :page_name, :in => ["base","static"]
end

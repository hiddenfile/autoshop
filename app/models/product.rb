class Product < ActiveRecord::Base
  belongs_to :company
  belongs_to :group
  has_many :photos, :as => :entity, :dependent => :destroy
  has_many :order_items

  has_many :backcalls, :dependent => :destroy

  validates :title, :presence => true, :length => {:minimum => 3, :maximum => 300}
  validates :company_id,:group_id, :numericality => true, :presence => true
  validates :status, :presence => true, :inclusion => { :in => ["new", "enable", "disable"] }

  before_save :update_product_description

  def update_product_description
    self.description = Nokogiri::HTML.parse(self.description).search("body").inner_html
  end
end

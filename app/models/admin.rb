class Admin < ActiveRecord::Base

  devise :database_authenticatable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_require?
  validates :email, :uniqueness => true, :presence => true, :format => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/

  protected
  def password_require?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end

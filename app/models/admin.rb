class Admin < ActiveRecord::Base

  devise :database_authenticatable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_require?

  protected
  def password_require?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end

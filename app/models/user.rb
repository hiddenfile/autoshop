class User < ActiveRecord::Base
  belongs_to :discount
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :validatable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:first_name,:last_name,:middle_name,:user_phone, :remember_me

  has_many :orders, :dependent => :destroy

  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_require?
  validates :email, :presence => true, :format => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :middle_name, :presence => true
  validates :user_phone, :presence => true, :format => /^\(?[+]?\(?([0-9]*)\)?[-. :]?([0-9]*)[-. :]?([0-9]*)[-. :]?([0-9]*)$/

  protected
  def password_require?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
end

class Admin < ActiveRecord::Base

  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end

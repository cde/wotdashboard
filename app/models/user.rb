class User < ActiveRecord::Base
  require 'devise'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable :registerable
  devise :database_authenticatable,:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :admin
  
  
  validates_presence_of :username
  validates_uniqueness_of :username, :email, :case_sensitive => false
end

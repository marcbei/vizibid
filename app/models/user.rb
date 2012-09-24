# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :id, :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_one :user_detail, :dependent => :destroy
  has_one :user_notification, :dependent => :destroy

  has_many :form_ratings
  has_many :rated_forms, :through => :form_ratings, :source => :form

  has_many :form_downloads
  has_many :downloads, :through => :form_downloads, :source => :form

  has_many :comments
  has_many :forms
  has_many :form_requests

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

end

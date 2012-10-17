# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  email                      :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  password_digest            :string(255)
#  remember_token             :string(255)
#  password_reset_token       :string(255)
#  password_reset_sent_at     :datetime
#  verification_token         :string(255)
#  verification_token_sent_at :datetime
#  bar_number                 :integer
#  state_licensed             :string(255)
#  verified                   :boolean
#

class User < ActiveRecord::Base
  attr_accessible :id, :email, :name, :password, :password_confirmation, :verification_token, :verification_token_sent_at, :bar_number, :state_licensed, :verified
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
  validates :password, presence: true, length: { minimum: 6 , maximum: 35}, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  validates_format_of :password, :with => /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,35}$/, :on => :create
  validates :bar_number,  presence: true
  validates :state_licensed,  presence: true

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
    Mailer.password_reset(self).deliver
  end

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end

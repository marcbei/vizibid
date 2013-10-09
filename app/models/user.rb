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
#  last_signin_at             :datetime
#

class User < ActiveRecord::Base
  attr_accessible :id, :email, :name, :password, :password_confirmation, :verification_token, :verification_token_sent_at, :bar_number, :state_licensed, :verified, :last_signin_at
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  has_one :user_detail, :dependent => :destroy
  has_one :user_notification, :dependent => :destroy

  has_many :form_ratings
  has_many :rated_forms, :through => :form_ratings, :source => :form

  has_many :form_downloads
  has_many :downloads, :through => :form_downloads, :source => :form

  has_many :form_views
  has_many :views, :through => :form_views, :source => :form

  has_many :user_permissions
  has_many :permissions, :through => :user_permissions, :source => :role

  has_many :form_follows
  has_many :followed_forms, :through => :form_follows, :source => :form

  has_many :user_practice_areas
  has_many :practice_areas, :through => :user_practice_areas

  has_many :comments
  has_many :forms
  has_many :request_submissions
  has_many :form_requests
  has_many :forum_posts
  has_many :forum_comments
  has_many :search_queries

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 , maximum: 35}, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  validates_format_of :password, :with => /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,35}$/, :on => :create
  validates :bar_number,  presence: true, length: { maximum: 9 }
  validates :state_licensed,  presence: true

  def request_submissions_count
    sum = 0
    self.form_requests.each{|fr| sum = sum + fr.RequestSubmissions.count}
    return sum
  end

  def request_submissions_with_forms_count
    sum = 0
    self.form_requests.each do |fr|
      fr.RequestSubmissions.each do |rs|
        if rs.form_id != nil 
          sum = sum + 1
        end
      end
    end 
    return sum
  end

  def number_of_users_responded_to_requests
    user_ids = Hash.new
    self.form_requests.each do |fr| 
      fr.RequestSubmissions.each do |rs| 
        user_ids[rs.user_id] = true 
      end
    end
    return user_ids.count
  end

  def number_of_comments_on_followed_forms_since_last_signin
    sum = 0
    self.followed_forms.each do |ff| 
      sum = sum + ff.comments.where("created_at > ?", self.last_signin_at).count
    end
    return sum
  end

  def number_of_iterations_on_followed_forms_since_last_signin
    sum = 0
    self.followed_forms.each do |ff| 
      ff.comments.where("created_at > ?", self.last_signin_at).each do |c|
        if Form.where("sourcecomment_id = ?", c.id).count != 0
          sum = sum + 1
        end
      end
    end
    return sum
  end

  def num_form_downloads
    sum = 0
    self.forms.each do |f|
      sum = sum + f.downloads.count
    end
    return sum
  end

  def num_days_since_upload
    days = 0
    if self.forms.count > 0
      days = self.forms.order("created_at DESC").first.created_at
    end
    return days
  end

  def num_days_since_comment
    days = 0
    if self.comments.count > 0
      days = self.comments.order("created_at DESC").first.created_at
    end
    return days
  end

  def average_form_rating
    sum = 0
    if self.forms.count != 0
      count = 0
      self.forms.each do |f|
        if !f.average_rating.nan?
          sum = sum + f.average_rating
          count = count + 1
        end
      end

      if count == 0
        average = 0
      else
        average = sum/count
      end
    else
      average = 0
    end
  end

  def num_comment_votes(upvotes, downvotes)
    upvotes = 0
    downvotes = 0
    self.comments.each do |c| 
      c.comment_votes.each do |cv|
        if cv.value == 1
          upvotes = upvotes + 1
        elsif cv.value == -1
          downvotes = downvotes + 1
        end
      end
    end
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!
    Mailer.delay.password_reset(self)
  end

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end

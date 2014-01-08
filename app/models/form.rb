# == Schema Information
#
# Table name: forms
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  description      :text
#  jurisdiction     :string(255)
#  keywords         :string(255)
#  sourcecomment_id :integer
#  approved         :boolean
#  practice_area_id :integer
#  origin           :string(255)
#  seed             :boolean
#  url              :text
#

class Form < ActiveRecord::Base

  require 'open-uri'

  attr_accessible :url, :user_id, :description, :jurisdiction, :keywords, :sourcecomment_id, :approved, :practice_area_id, :origin, :seed

  #mount_uploader :form, FormsUploader

  has_many :RequestSubmissions, dependent: :destroy
  has_many :form_requests, :through => :RequestSubmissions

  has_many :form_ratings, dependent: :destroy
  has_many :raters, :through => :form_ratings, :source => :user

  has_many :form_downloads, dependent: :destroy
  has_many :downloads, :through => :form_downloads, :source => :user

  has_many :form_views, dependent: :destroy
  has_many :views, :through => :form_views, :source => :user

  has_many :form_permissions, dependent: :destroy
  has_many :permissions, :through => :form_permissions, :source => :role

  has_many :comments, dependent: :destroy
  belongs_to :user

  belongs_to :practice_area

  validates :url, :presence => true
  validates :description, :presence => true
  validates :jurisdiction, :presence => true

  #searchable do
 #   text :description, :boost => 3
 #   text :keywords, :boost => 2
 #   text :jurisdiction
  #  text :user do
  #    user.name
  #  end
 #   text :comments do
 #     comments.map(&:content)
 #   end
 #   boolean :approved

 #   attachment :document_attachment
 # end
  
  def document_attachment
    URI.parse(url)
  end

  def average_rating
    @value = 0
    self.form_ratings.each do |rating|
        @value = @value + rating.value
    end

    @total = self.form_ratings.size
    @value.to_f / @total.to_f
  end

end

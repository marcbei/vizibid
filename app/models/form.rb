# == Schema Information
#
# Table name: forms
#
#  id               :integer          not null, primary key
#  form             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  description      :text
#  jurisdiction     :string(255)
#  keywords         :string(255)
#  name             :string(255)
#  sourcecomment_id :integer
#

class Form < ActiveRecord::Base
  attr_accessible :form, :user_id, :NumDownload, :description, :jurisdiction, :keywords, :name, :sourcecomment_id

  mount_uploader :form, FormsUploader

  has_many :RequestSubmissions
  has_many :form_requests, :through => :RequestSubmissions

  has_many :form_ratings
  has_many :raters, :through => :form_ratings, :source => :user

  has_many :form_downloads
  has_many :downloads, :through => :form_downloads, :source => :user

  has_many :comments
  belongs_to :user

  validates :form, :presence => true
  validates :name, :presence => true
  validates :jurisdiction, :presence => true

  searchable do
    text :name, :boost => 3
    text :keywords, :boost => 2
    text :description, :jurisdiction
    text :user do
      user.name
    end
    text :comments do
      comments.map(&:content)
    end
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

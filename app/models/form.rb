# == Schema Information
#
# Table name: forms
#
#  id            :integer          not null, primary key
#  form          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  num_downloads :integer
#  description   :text
#  jurisdiction  :string(255)
#  keywords      :string(255)
#  name          :string(255)

class Form < ActiveRecord::Base
  attr_accessible :form, :user_id, :NumDownload, :description, :jurisdiction, :keywords, :name

  mount_uploader :form, FormsUploader

  has_many :RequestSubmissions
  has_many :form_requests, :through => :RequestSubmissions

  has_many :comments
  belongs_to :user

  validates :form, :presence => true, :length => {:minimum => 5}
  validates :name, :presence => true
  validates :jurisdiction, :presence => true

  def self.search(search)
  	if search
      	find(:all, :conditions => ['form ILIKE ?', "%#{search}%"])
  	else
  	    find(:all)
  	end
  end
end

# == Schema Information
#
# Table name: form_requests
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  jurisdiction :string(255)
#  keywords     :string(255)
#  anonymous    :boolean
#  fufilled     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

class FormRequest < ActiveRecord::Base
  attr_accessible :anonymous, :description, :fufilled, :jurisdiction, :keywords, :name, :form_id

  belongs_to :user

  has_many :RequestSubmissions
  has_many :forms, :through => :RequestSubmissions

  validates :description, :presence => true
  validates :jurisdiction, :presence => true
  validates :name, :presence => true

end
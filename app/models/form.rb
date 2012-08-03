# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  form       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Form < ActiveRecord::Base
  attr_accessible :form, :user_id

  mount_uploader :form, FormsUploader

  has_many :comments
  belongs_to :user

  validates :form, :presence=>true, :length => {:minimum => 5}

  def self.search(search)
  	if search
      	find(:all, :conditions => ['form ILIKE ?', "%#{search}%"])
  	else
  	    find(:all)
  	end
  end
end

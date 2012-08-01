# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  form       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Form < ActiveRecord::Base
  attr_accessible :form

  mount_uploader :form, FormsUploader

  has_many :comments

  validates :form, :presence=>true, :length => {:minimum => 5}

  def self.search(search)
  	if search
      	find(:all, :conditions => ['form ILIKE ?', "%#{search}%"])
  	else
  	    find(:all)
  	end
  end
end

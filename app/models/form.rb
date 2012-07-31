class Form < ActiveRecord::Base
  attr_accessible :form

  mount_uploader :form, FormsUploader

  validates :form, :presence=>true, :length => {:minimum => 5}

  def self.search(search)
	if search
    	find(:all, :conditions => ['form ILIKE ?', "%#{search}%"])
	else
	    find(:all)
  	end
  end
end

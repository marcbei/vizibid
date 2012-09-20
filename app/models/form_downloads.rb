# == Schema Information
#
# Table name: form_downloads
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormDownloads < ActiveRecord::Base
  attr_accessible :form_id, :user_id

  belongs_to :user
  belongs_to :form

end

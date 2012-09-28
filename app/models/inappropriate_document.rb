# == Schema Information
#
# Table name: inappropriate_documents
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InappropriateDocument < ActiveRecord::Base
  attr_accessible :form_id, :user_id

  validates :form_id, presence: true
  validates :user_id, presence: true
end

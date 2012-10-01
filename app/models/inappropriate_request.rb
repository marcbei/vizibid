# == Schema Information
#
# Table name: inappropriate_requests
#
#  id         :integer          not null, primary key
#  request_id :integer
#  user_id    :integer
#  reason     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class InappropriateRequest < ActiveRecord::Base
  attr_accessible :reason, :request_id, :user_id

  validates :request_id, presence: true
  validates :user_id, presence: true
end

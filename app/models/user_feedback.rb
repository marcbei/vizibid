# == Schema Information
#
# Table name: user_feedbacks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  subject    :text
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserFeedback < ActiveRecord::Base
  attr_accessible :comment, :subject, :user_id

  validates :comment, presence: true
  validates :subject, presence: true
  validates :user_id, presence: true

end

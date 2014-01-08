# == Schema Information
#
# Table name: user_notifications
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  requests   :boolean
#  forms      :boolean
#  news       :boolean
#  tips       :boolean
#  surveys    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserNotification < ActiveRecord::Base
  attr_accessible :user_id, :forms, :news, :requests, :surveys, :tips, :downloads

  belongs_to :user

end

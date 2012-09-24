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

require 'spec_helper'

describe UserNotification do
  pending "add some examples to (or delete) #{__FILE__}"
end

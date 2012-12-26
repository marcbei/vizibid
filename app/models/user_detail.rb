# == Schema Information
#
# Table name: user_details
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  location      :string(255)
#  website       :string(255)
#  practice_area :text
#  bio           :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  show_comments :boolean
#  show_uploaded :boolean
#  show_requests :boolean
#

class UserDetail < ActiveRecord::Base
  attr_accessible :bio, :location, :practice_area, :user_id, :website, :show_comments, :show_uploaded, :show_requests

  belongs_to :user

end

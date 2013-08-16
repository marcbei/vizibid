# == Schema Information
#
# Table name: user_practice_areas
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  practice_area_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserPracticeArea < ActiveRecord::Base
  attr_accessible :practice_area_id, :user_id

  belongs_to :practice_area
  belongs_to :user
end

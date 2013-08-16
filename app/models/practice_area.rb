# == Schema Information
#
# Table name: practice_areas
#
#  id            :integer          not null, primary key
#  practice_area :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PracticeArea < ActiveRecord::Base
  attr_accessible :practice_area

  has_many :forms
  has_many :form_requests

  has_many :user_practice_areas
  has_many :users, :through => :user_practice_areas

end

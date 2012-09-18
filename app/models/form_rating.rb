# == Schema Information
#
# Table name: form_ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  form_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormRating < ActiveRecord::Base
  attr_accessible :form_id, :user_id, :value

  belongs_to :user
  belongs_to :form

end

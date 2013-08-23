# == Schema Information
#
# Table name: form_views
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormView < ActiveRecord::Base
  attr_accessible :form_id, :user_id

  belongs_to :user
  belongs_to :form

end

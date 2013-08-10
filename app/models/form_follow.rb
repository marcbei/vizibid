# == Schema Information
#
# Table name: form_follows
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormFollow < ActiveRecord::Base
  attr_accessible :form_id, :user_id
end

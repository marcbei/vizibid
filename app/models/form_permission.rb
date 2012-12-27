# == Schema Information
#
# Table name: form_permissions
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FormPermission < ActiveRecord::Base
  attr_accessible :form_id, :role_id

  belongs_to :form
  belongs_to :role

end

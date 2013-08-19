# == Schema Information
#
# Table name: shared_forms
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  form_id       :integer
#  email_address :string(255)
#  description   :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SharedForm < ActiveRecord::Base
  attr_accessible :description, :email_address, :form_id, :user_id

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email_address, presence: true, format: { with: VALID_EMAIL_REGEX }
end

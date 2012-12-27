# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  access_code :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ActiveRecord::Base
  attr_accessible :access_code, :name

  has_many :user_permissions
  has_many :users, :through => :user_permissions, :source => :user

  has_many :form_permissions
  has_many :forms, :through => :form_permissions, :source => :form

end

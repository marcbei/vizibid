# == Schema Information
#
# Table name: request_submissions
#
#  id              :integer          not null, primary key
#  form_id         :integer
#  form_request_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  comment         :text
#  user_id         :integer
#  accepted        :boolean
#

class RequestSubmission < ActiveRecord::Base
   attr_accessible :form_request_id, :form_id, :comment, :user_id, :parent_id, :accepted

   belongs_to :form_request
   belongs_to :form

   validates :comment, :presence => true
   validates :form_request_id, :presence => true

end

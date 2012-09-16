# == Schema Information
#
# Table name: request_submissions
#
#  id              :integer          not null, primary key
#  form_id         :integer
#  form_request_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RequestSubmission < ActiveRecord::Base
   attr_accessible :formrequest_id, :form_id

   belongs_to :form_request
   belongs_to :form
end

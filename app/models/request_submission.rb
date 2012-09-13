# == Schema Information
#
# Table name: request_submissions
#
#  id             :integer          not null, primary key
#  formrequest_id :integer
#  form_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class RequestSubmission < ActiveRecord::Base
   attr_accessible :formrequest_id, :form_id

   belongs_to :formrequest
   belongs_to :form
end

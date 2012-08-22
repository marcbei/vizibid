# == Schema Information
#
# Table name: form_requests
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  jurisdiction :string(255)
#  keywords     :string(255)
#  anonymous    :boolean
#  fufilled     :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

require 'spec_helper'

describe FormRequest do
  pending "add some examples to (or delete) #{__FILE__}"
end

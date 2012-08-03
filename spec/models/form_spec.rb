# == Schema Information
#
# Table name: forms
#
#  id         :integer          not null, primary key
#  form       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'spec_helper'

describe Form do
  pending "add some examples to (or delete) #{__FILE__}"
end

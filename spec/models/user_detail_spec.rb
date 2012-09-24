# == Schema Information
#
# Table name: user_details
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  location      :string(255)
#  website       :string(255)
#  practice_area :text
#  bio           :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe UserDetail do
  pending "add some examples to (or delete) #{__FILE__}"
end

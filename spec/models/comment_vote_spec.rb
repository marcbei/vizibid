# == Schema Information
#
# Table name: comment_votes
#
#  id         :integer          not null, primary key
#  comment_id :integer
#  user_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe CommentVote do
  pending "add some examples to (or delete) #{__FILE__}"
end

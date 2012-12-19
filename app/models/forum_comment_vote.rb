# == Schema Information
#
# Table name: forum_comment_votes
#
#  id         :integer          not null, primary key
#  comment_id :integer
#  user_id    :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ForumCommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :value

  belongs_to :user
  belongs_to :comment

  has_many :forum_comment_votes

  validates :value, presence: true 
  validates :comment_id, presence: true 
  validates :user_id, presence: true 
end

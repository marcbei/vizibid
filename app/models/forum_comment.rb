# == Schema Information
#
# Table name: forum_comments
#
#  id            :integer          not null, primary key
#  content       :text
#  forum_post_id :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ancestry      :string(255)
#  score         :integer
#

class ForumComment < ActiveRecord::Base
  attr_accessible :content, :post_id, :user_id, :forum_post_id, :parent_id, :ancestry

  has_ancestry

  belongs_to :user
  belongs_to :forum_post

end

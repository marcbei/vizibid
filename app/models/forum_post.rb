# == Schema Information
#
# Table name: forum_posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  message    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ForumPost < ActiveRecord::Base
  attr_accessible :message, :title, :user_id

  belongs_to :user

  has_many :forum_comments

  searchable do
    text :title, :boost => 3
    text :message, :boost => 2
    text :user do
      user.name
    end
    text :forum_comments do
      forum_comments.map(&:content)
    end
  end

end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  user_id    :integer
#  form_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string(255)
#  score      :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :form_id, :parent_id, :ancestry, :score

  has_ancestry

  belongs_to :user
  belongs_to :form

  has_many :comment_votes
  has_many :commenters, :through => :comment_votes, :source => :user

  validates :content, presence: true, length: { maximum: 400 }
  validates :user_id, presence: true
  validates :form_id, presence: true

end

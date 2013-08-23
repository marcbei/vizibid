# == Schema Information
#
# Table name: search_queries
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  query      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchQuery < ActiveRecord::Base
  attr_accessible :query, :user_id

  belongs_to :user
end

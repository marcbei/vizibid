class AddScoreToForumComment < ActiveRecord::Migration
  def change
    add_column :forum_comments, :score, :integer
  end
end

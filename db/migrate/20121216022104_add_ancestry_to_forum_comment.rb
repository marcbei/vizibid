class AddAncestryToForumComment < ActiveRecord::Migration
  def change
    add_column :forum_comments, :ancestry, :string
  end
end

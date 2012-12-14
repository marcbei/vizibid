class RenameFormCommentFKeyColumn < ActiveRecord::Migration
  def up
  	rename_column :forum_comments, :post_id, :forum_post_id
  end

  def down
  end
end

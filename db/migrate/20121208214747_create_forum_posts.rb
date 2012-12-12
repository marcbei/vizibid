class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.string :title
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end

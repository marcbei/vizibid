class CreateForumComments < ActiveRecord::Migration
  def change
    create_table :forum_comments do |t|
      t.text :content
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end

class CreateCommentVotes < ActiveRecord::Migration
  def up
  	create_table :comment_votes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :value

      t.timestamps
    end
  end

  def down
  	drop_table :comment_votes 
  end
end

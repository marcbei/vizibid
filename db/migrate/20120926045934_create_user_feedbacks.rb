class CreateUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :user_feedbacks do |t|
      t.integer :user_id
      t.text :subject
      t.text :comment

      t.timestamps
    end
  end
end

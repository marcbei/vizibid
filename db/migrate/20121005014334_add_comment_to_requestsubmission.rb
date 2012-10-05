class AddCommentToRequestsubmission < ActiveRecord::Migration
  def change
    add_column :request_submissions, :comment, :text
  end
end

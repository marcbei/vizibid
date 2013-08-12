class RemoveAncestryFromRequestSubmission < ActiveRecord::Migration
  def change
  	remove_column :request_submissions, :ancestry
  end
end

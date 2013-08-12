class AddAcceptedToRequestSubmission < ActiveRecord::Migration
  def change
    add_column :request_submissions, :accepted, :boolean
  end
end

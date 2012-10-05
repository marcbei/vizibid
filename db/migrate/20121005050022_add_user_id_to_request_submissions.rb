class AddUserIdToRequestSubmissions < ActiveRecord::Migration
  def change
    add_column :request_submissions, :user_id, :integer
  end
end

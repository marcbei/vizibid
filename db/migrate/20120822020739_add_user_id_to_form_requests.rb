class AddUserIdToFormRequests < ActiveRecord::Migration
  def change
    add_column :form_requests, :user_id, :integer
  end
end

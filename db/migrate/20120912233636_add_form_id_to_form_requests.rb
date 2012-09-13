class AddFormIdToFormRequests < ActiveRecord::Migration
  def change
    add_column :form_requests, :form_id, :integer
  end
end

class Grrrr < ActiveRecord::Migration
  def up
  	rename_column :request_submissions, :formrequest_id, :form_request_id
  end

  def down
  end
end

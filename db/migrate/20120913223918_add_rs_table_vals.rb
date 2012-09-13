class AddRsTableVals < ActiveRecord::Migration
  def chagne
  	add_column :request_submissions, :form_id, :integer
  	add_column :request_submissions, :formrequest_id, :integer
  	add_column :request_submissions, :timestamps
  end
end

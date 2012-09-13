class ChangeRsTableName1 < ActiveRecord::Migration
  def change
  	rename_table :RequestSubmissions, :request_submissions
  end
end

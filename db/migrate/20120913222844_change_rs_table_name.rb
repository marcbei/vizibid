class ChangeRsTableName < ActiveRecord::Migration
  def change
  	rename_table :RequestSubmission, :RequestSubmissions
  end
end

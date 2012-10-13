class AddShowcommentsShowuploadedShowdownloadedToUserDetail < ActiveRecord::Migration
  def change
  	add_column :user_details, :show_comments, :boolean
  	add_column :user_details, :show_uploaded, :boolean
  	add_column :user_details, :show_downloaded, :boolean
  	add_column :user_details, :show_requests, :boolean
  end
end

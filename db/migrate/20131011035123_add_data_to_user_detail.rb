class AddDataToUserDetail < ActiveRecord::Migration
  def change
  	add_column :user_details, :show_location, :boolean
  	add_column :user_details, :show_website, :boolean
  	add_column :user_details, :show_bio, :boolean
  	add_column :user_details, :show_practice_area, :boolean
  	add_column :user_details, :show_email, :boolean
  end
end
class RemoveUserDetails < ActiveRecord::Migration
  def up
  	drop_table :user_details
  end

  def down
  end
end

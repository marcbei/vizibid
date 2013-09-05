class AddSignInTimeToUser < ActiveRecord::Migration
  def change
  	add_column :users, :last_signin_date_time, :datetime
  end
end

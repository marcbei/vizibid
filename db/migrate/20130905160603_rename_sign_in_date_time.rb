class RenameSignInDateTime < ActiveRecord::Migration
  def up
  	rename_column :users, :last_signin_date_time, :last_signin_at
  end

  def down
  end
end

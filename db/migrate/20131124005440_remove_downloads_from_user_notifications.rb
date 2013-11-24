class RemoveDownloadsFromUserNotifications < ActiveRecord::Migration
  def up
    remove_column :user_notifications, :downloads
  end

  def down
    add_column :user_notifications, :downloads, :boolean
  end
end

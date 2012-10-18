class AddDownloadsToUserNotifications < ActiveRecord::Migration
  def change
    add_column :user_notifications, :downloads, :boolean
  end
end

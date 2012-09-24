class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.boolean :requests
      t.boolean :forms
      t.boolean :news
      t.boolean :tips
      t.boolean :surveys

      t.timestamps
    end
  end
end

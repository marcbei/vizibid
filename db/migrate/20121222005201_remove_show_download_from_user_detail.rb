class RemoveShowDownloadFromUserDetail < ActiveRecord::Migration
  def up
  	remove_column :user_details, :show_downloaded
  end

  def down
  end
end

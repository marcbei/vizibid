class AddNumDownloadsToForm < ActiveRecord::Migration
  def change
    add_column :forms, :num_downloads, :integer
  end

  def down
  	remove_column :forms, :NumDownload
  end
end

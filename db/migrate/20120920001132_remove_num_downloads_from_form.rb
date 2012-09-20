class RemoveNumDownloadsFromForm < ActiveRecord::Migration
  def up
  	remove_column(:forms, :num_downloads)
  end

  def down
  end
end

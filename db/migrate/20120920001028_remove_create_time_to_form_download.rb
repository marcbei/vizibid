class RemoveCreateTimeToFormDownload < ActiveRecord::Migration
  def up
  	remove_column(:form_downloads, :downloadtime)
  end

  def down
  end
end

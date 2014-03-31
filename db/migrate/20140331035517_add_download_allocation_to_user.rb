class AddDownloadAllocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :download_allocation, :integer
  end
end

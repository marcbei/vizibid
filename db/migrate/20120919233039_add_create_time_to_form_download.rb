class AddCreateTimeToFormDownload < ActiveRecord::Migration
  def change
  	add_column(:form_downloads, :downloadtime, :datetime)
  end
end

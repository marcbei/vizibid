class CreateFormDownloads < ActiveRecord::Migration
  def change
    create_table :form_downloads do |t|
      t.integer :form_id
      t.integer :user_id

      t.timestamps
    end
  end
end

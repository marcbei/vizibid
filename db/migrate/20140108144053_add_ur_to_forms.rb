class AddUrToForms < ActiveRecord::Migration
  def change
    add_column :forms, :url, :text
  end
end

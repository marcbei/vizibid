class AddClearToForms < ActiveRecord::Migration
  def change
  	add_column :forms, :approved, :boolean
  end
end

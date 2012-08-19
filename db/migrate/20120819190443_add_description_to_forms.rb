class AddDescriptionToForms < ActiveRecord::Migration
  def change
    add_column :forms, :description, :string
  end
end

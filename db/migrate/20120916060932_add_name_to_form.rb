class AddNameToForm < ActiveRecord::Migration
  def change
  	add_column :forms, :name, :string
  end
end

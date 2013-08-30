class RemoveNameFromForm < ActiveRecord::Migration
  def up
  	remove_column :forms, :name
  end

  def down
  end
end

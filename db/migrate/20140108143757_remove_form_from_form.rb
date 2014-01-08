class RemoveFormFromForm < ActiveRecord::Migration
  def up
  	remove_column :forms, :form
  end

  def down
  end
end

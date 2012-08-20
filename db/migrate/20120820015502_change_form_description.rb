class ChangeFormDescription < ActiveRecord::Migration
  def up
  	change_column :forms, :description, :text
  end

  def down
  end
end

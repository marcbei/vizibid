class AddCommmentsToForm < ActiveRecord::Migration
  def change
    add_column :forms, :keywords, :string
  end
end

class AddSourcecommentIdToForms < ActiveRecord::Migration
  def change
    add_column :forms, :sourcecomment_id, :integer
  end
end

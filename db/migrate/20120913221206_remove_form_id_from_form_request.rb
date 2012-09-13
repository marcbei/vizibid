class RemoveFormIdFromFormRequest < ActiveRecord::Migration
  def change
  	remove_column :form_requests, :form_id
  end
end

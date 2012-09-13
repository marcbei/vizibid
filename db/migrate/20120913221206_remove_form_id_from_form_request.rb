class RemoveFormIdFromFormRequest < ActiveRecord::Migration
  def change
  	remove_column :formt_requests, :form_id
  end
end

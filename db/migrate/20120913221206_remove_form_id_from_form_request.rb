class RemoveFormIdFromFormRequest < ActiveRecord::Migration
  def change
  	:remove_column, :form_id
  end
end

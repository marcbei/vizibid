class AddPracticeAreaToFormRequest < ActiveRecord::Migration
  def change
    add_column :form_requests, :practice_area_id, :integer
  end
end

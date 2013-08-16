class RenameColumnInUserPracticeAreas < ActiveRecord::Migration
  def up
  	rename_column :user_practice_areas, :practicearea_id, :practice_area_id
  end

  def down
  end
end

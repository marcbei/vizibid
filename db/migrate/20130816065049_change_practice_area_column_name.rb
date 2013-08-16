class ChangePracticeAreaColumnName < ActiveRecord::Migration
  def up
	rename_column :practice_areas, :practice_area, :practice_area_title
  end

  def down
  end
end

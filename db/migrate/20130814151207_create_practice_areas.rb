class CreatePracticeAreas < ActiveRecord::Migration
  def change
    create_table :practice_areas do |t|
      t.string :practice_area

      t.timestamps
    end

   	add_column :forms, :practice_area_id, :integer

  end
end

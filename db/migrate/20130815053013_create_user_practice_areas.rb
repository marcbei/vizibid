class CreateUserPracticeAreas < ActiveRecord::Migration
  def change
    create_table :user_practice_areas do |t|
      t.integer :user_id
      t.integer :practicearea_id

      t.timestamps
    end
  end
end

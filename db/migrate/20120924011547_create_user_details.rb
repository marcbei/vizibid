class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :user_id
      t.string :location
      t.string :website
      t.text :practice_area
      t.text :bio

      t.timestamps
    end
  end
end

class CreateFormRatings < ActiveRecord::Migration
  def change
    create_table :form_ratings do |t|
      t.integer :user_id
      t.integer :form_id
      t.integer :value

      t.timestamps
    end
  end
end

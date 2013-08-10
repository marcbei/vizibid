class CreateFormFollows < ActiveRecord::Migration
  def change
    create_table :form_follows do |t|
      t.integer :user_id
      t.integer :form_id

      t.timestamps
    end
  end
end

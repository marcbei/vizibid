class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :form_id

      t.timestamps
    end
    add_index :comments, [:form_id, :created_at]
  end
end

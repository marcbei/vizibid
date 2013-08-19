class CreateSharedForms < ActiveRecord::Migration
  def change
    create_table :shared_forms do |t|
      t.integer :user_id
      t.integer :form_id
      t.string :email_address
      t.string :description

      t.timestamps
    end
  end
end

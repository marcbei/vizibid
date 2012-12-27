class CreateFormPermissions < ActiveRecord::Migration
  def change
    create_table :form_permissions do |t|
      t.integer :role_id
      t.integer :form_id

      t.timestamps
    end
  end
end

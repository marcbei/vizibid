class AddRsTable < ActiveRecord::Migration
  def up
  	  create_table :request_submissions do |t|
      t.integer :form_id
      t.integer :formrequest_id

      t.timestamps
    end
  end

  def down
  end
end

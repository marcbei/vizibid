class CreateRequestSubmission < ActiveRecord::Migration
  def up
  	create_table :RequestSubmission do |t|
      t.integer :form_id
      t.integer :formrequest_id

      t.timestamps
    end
  end

  def down
  end
end

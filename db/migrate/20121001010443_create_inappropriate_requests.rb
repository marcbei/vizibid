class CreateInappropriateRequests < ActiveRecord::Migration
  def change
    create_table :inappropriate_requests do |t|
      t.integer :request_id
      t.integer :user_id
      t.text :reason

      t.timestamps
    end
  end
end

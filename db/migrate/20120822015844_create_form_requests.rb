class CreateFormRequests < ActiveRecord::Migration
  def change
    create_table :form_requests do |t|
      t.string :name
      t.text :description
      t.string :jurisdiction
      t.string :keywords
      t.boolean :anonymous
      t.boolean :fufilled

      t.timestamps
    end
  end
end

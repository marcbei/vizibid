class CreateInappropriateDocuments < ActiveRecord::Migration
  def change
    create_table :inappropriate_documents do |t|
      t.integer :form_id
      t.integer :user_id

      t.timestamps
    end
  end
end

class AddReasonToInappropriateDocuments < ActiveRecord::Migration
  def change
    add_column :inappropriate_documents, :reason, :text
  end
end

class AddAncestryToRequestSubmissions < ActiveRecord::Migration
  def change
    add_column :request_submissions, :ancestry, :string
    add_index :request_submissions, :ancestry
  end
end

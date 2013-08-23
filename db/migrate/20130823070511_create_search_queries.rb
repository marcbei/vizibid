class CreateSearchQueries < ActiveRecord::Migration
  def change
    create_table :search_queries do |t|
      t.integer :user_id
      t.text :query

      t.timestamps
    end
  end
end

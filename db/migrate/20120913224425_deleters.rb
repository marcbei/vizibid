class Deleters < ActiveRecord::Migration
  def change
  	drop_table :request_submissions
  end
end

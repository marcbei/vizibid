class CreateRoles < ActiveRecord::Migration
  def change
  	drop_table :roles
    create_table :roles do |t|
      t.string :name
      t.integer :access_code

      t.timestamps
    end
  end
end

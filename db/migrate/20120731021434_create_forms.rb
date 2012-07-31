class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :form

      t.timestamps
    end
  end
end

class AddOriginSeedToForm < ActiveRecord::Migration
  def change
    add_column :forms, :origin, :string
    add_column :forms, :seed, :boolean
  end
end

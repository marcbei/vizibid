class AddBarNumberAddVerificationToUser < ActiveRecord::Migration
 def change
    add_column :users, :verification_token, :string
    add_column :users, :verification_token_sent_at, :datetime
    add_column :users, :bar_number, :integer
    add_column :users, :state_licensed, :string
    add_column :users, :verified, :boolean
  end
end

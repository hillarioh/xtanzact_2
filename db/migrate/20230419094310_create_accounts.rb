class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      
      t.integer "account_type", default: 0
      t.float "balance", default: 0
      t.references :user, foreign_key: {to_table: :users }

      t.timestamps
    end
  end
end

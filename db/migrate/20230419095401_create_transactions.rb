class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer "transaction_type", default: 0
      t.float "amount", default: 0
      t.references :account, foreign_key: {to_table: :accounts }

      t.timestamps
    end
  end
end

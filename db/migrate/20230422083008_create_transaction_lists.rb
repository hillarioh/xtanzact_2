class CreateTransactionLists < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_lists do |t|
      t.references :account, foreign_key: {to_table: :accounts }
      t.references :transactionable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float "amount", null: false
      t.references :sender, foreign_key: {to_table: :accounts }
      t.references :receiver, foreign_key: {to_table: :accounts }
      t.timestamps
    end
  end
end

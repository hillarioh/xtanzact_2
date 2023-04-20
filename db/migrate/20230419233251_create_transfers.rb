class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.float :amount
      t.references :sender, foreign_key: {to_table: :accounts }
      t.references :receiver, foreign_key: {to_table: :accounts }

      t.timestamps
    end
  end
end

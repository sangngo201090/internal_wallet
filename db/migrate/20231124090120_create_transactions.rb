class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, foreign_key: { to_table: :wallets }
      t.references :target_wallet, foreign_key: { to_table: :wallets }
      t.decimal :amount, precision: 10, scale: 2
      # description is a string that describes the transaction (ex: "Transfer to wallet 1" in case of a credit transaction, "Transfer from wallet 1" in case of a debit transaction)
      t.string :description
      # message is a string that contains a message from the source wallet to the target wallet (ex: "Happy birthday!" in case of a gift transaction)
      t.string :message

      t.timestamps
    end
  end
end

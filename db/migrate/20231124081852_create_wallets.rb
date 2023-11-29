class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.string :name

      t.timestamps
    end
  end
end

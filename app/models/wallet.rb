class Wallet < ApplicationRecord
    has_one :entity, dependent: :destroy

    has_many :credit_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'
    has_many :debit_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'

    def balance
        credit_transactions.sum(:amount) - debit_transactions.sum(:amount)
    end
end
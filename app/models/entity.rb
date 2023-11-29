class Entity < ApplicationRecord
    belongs_to :wallet, dependent: :destroy
    has_many :transactions, through: :wallet
    belongs_to :system_user, dependent: :destroy

    validates :name, presence: true
end
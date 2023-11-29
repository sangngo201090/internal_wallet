class Stock < Entity
    validates :description, presence: true
    validates :symbol, presence: true, uniqueness: true
end
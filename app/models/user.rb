class User < Entity
    validates :birth_date, presence: true
end
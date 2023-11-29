class SystemUser < ApplicationRecord
    has_one :entities, dependent: :destroy

    validates :user_name, presence: true
    validates :password, presence: true

    def authenticate(username, password)
        user = SystemUser.find_by(user_name: username)
        return nil unless user
      
        return nil unless Digest::MD5.hexdigest(password) == user.password

        user
    end
    
end
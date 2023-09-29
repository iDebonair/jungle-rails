class User < ApplicationRecord
    has_secure_password
<<<<<<< HEAD
  
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  
=======

    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
>>>>>>> feature/user-auth

class User < ApplicationRecord
    has_many :snapshots

    before_save { self.email = email.downcase } # before an email is saved in the db, convert all the characters to lowercase

    # the name and email fields can't be a blank string and can't be too long
    validates :name, presence: true, length: { maximum: 60 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true  # allow a nil password when updating username or email

    # works out the cost parameter that determines the computational cost to calculate the hash
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

end

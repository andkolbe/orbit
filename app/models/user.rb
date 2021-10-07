class User < ApplicationRecord
    before_save { self.email = email.downcase } # before an email is saved in the db, convert all the characters to lowercase

    # the name and email fields can't be a blank string and can't be too long
    validates :name, presence: true, length: { maximum: 60 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

    has_secure_password

    validates :password, presence: true, length: { minimum: 6 }

end

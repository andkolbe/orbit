class User < ApplicationRecord
    # the name and email fields can't be a blank string and can't be too long
    validates :name, presence: true, length: { maximum: 60 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end

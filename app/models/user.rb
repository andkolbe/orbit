class User < ApplicationRecord
    # the name and email fields can't be a blank string and can't be too long
    validates :name, presence: true, length: { maximum: 60 }
    validates :email, presence: true, length: { maximum: 255 }
end

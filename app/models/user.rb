class User < ApplicationRecord
    # the name and email fields can't be a blank string
    validates :name, presence: true 
    validates :email, presence: true
end

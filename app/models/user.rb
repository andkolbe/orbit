class User < ApplicationRecord
    has_many :snapshots, dependent: :destroy # any dependent snapshots are deleted if the user is deleted
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

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

    def feed
      Snapshot.where("user_id IN (?) OR user_id =?", following_ids, id)
    end

    def follow(other_user)
        following << other_user
      end
    
      def unfollow(other_user)
        following.delete(other_user)
      end
    
      def following?(other_user)
        following.include?(other_user)
      end
end

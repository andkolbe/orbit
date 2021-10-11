class Snapshot < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # this is a lambda function
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
end
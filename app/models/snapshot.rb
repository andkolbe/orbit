class Snapshot < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) } # this is a lambda function
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "Please upload a  valid file type (jpeg, gif, png)."},
                                  size: { less_than: 5.megabytes, message: "Your image exceeds 5MB." }
end

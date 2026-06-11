class Complaint < ApplicationRecord
  belongs_to :user
  
  # This enables the conversation thread
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy
  
  validates :message, presence: true
  has_one_attached :image
  validates :image, content_type: ['image/png', 'image/jpeg'],
        size: { less_than: 5.megabytes, message: 'is too large' }

  def thumbnail
    image.variant(resize_to_limit: [150, 150])
  end
end
class Complaint < ApplicationRecord
  belongs_to :user
  
  # This enables the conversation thread
  has_many :comments, -> { order(created_at: :asc) }, dependent: :destroy
  
  validates :message, presence: true
end
class Room < ApplicationRecord
  belongs_to :block
  has_many :allocations
  validates :room_number, presence: true, uniqueness: { scope: :block_id }
  validates :capacity, numericality: { greater_than: 0 }

  def available?
    # A room is available if it has no active allocations
    allocations.where(status: :active).count < self.capacity
  end
end
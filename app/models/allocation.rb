class Allocation < ApplicationRecord
  # Better: Define the association properly
  belongs_to :room
  belongs_to :student, class_name: 'User', foreign_key: 'student_id'
  
  after_initialize :set_default_status, if: :new_record?
  
  validates :student_id, presence: true
  validate :user_must_not_have_another_active_allocation, on: :create, if: -> { active? }
  validate :room_has_capacity, if: -> { active? }
  
  enum :status, { active: 0, inactive: 1 }

  private

  def set_default_status
    self.status ||= :active
  end

  def room_has_capacity
    # Using 'count' is fine, but checking 'size' or 'exists?' 
    # is faster if you just need to know if it hit the limit
    if room.allocations.where(status: :active).where.not(id: id).count >= 2
      errors.add(:room, "is already full")
    end
  end

  def user_must_not_have_another_active_allocation
    if Allocation.where(student_id: student_id, status: :active).where.not(id: id).exists?
      errors.add(:student_id, "is already allocated to another room.")
    end
  end
end
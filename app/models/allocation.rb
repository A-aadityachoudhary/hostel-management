class Allocation < ApplicationRecord
  # We remove the association to 'student' and use a standard lookup
  # This prevents Rails from performing ANY automatic table lookups
  
  belongs_to :room
  after_initialize :set_default_status, if: :new_record?
  # Just treat student_id as an integer for now
  validates :student_id, presence: true
  validate :user_must_not_have_another_active_allocation, on: :create, if: -> { active? }
  
  enum :status, { active: 0, inactive: 1 }

  # Helper method to get the user
  def student
    User.find(student_id)
  end

  validate :room_has_capacity, if: -> { active? }

  private

  def set_default_status
    self.status ||= :active
  end

  def room_has_capacity
    query = Allocation.where(room_id: room_id, status: :active)
    query = query.where.not(id: id) if persisted?
    
    if query.count >= 2
      errors.add(:room, "is already full")
    end
  end

  def user_must_not_have_another_active_allocation
    # Check if the same student already has an active allocation
    if Allocation.where(student_id: student_id, status: :active).exists?
      errors.add(:student_id, "is already allocated to another room.")
    end
  end
end
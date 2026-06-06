class Allocation < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :room
  enum status: { active: 0, past: 1 }
end
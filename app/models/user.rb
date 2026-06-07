class User < ApplicationRecord
  has_secure_password
  enum :role, { student: 0, staff: 1, admin: 2 }
  has_many :allocations, foreign_key: :student_id
  has_many :tasks, foreign_key: 'staff_id', dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
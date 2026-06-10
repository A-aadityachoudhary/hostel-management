class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :role, { student: 0, staff: 1, admin: 2 }
  has_many :allocations, foreign_key: :student_id
  has_many :complaints
  has_many :tasks, foreign_key: 'staff_id', dependent: :destroy
  validates :name, presence: true
end
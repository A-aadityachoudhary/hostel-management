# app/models/task.rb
class Task < ApplicationRecord
  # Staff member who performs the task
  belongs_to :staff, class_name: 'User'
  # Admin who assigned it
  belongs_to :admin, class_name: 'User'

  enum :status, { pending: 0, in_progress: 1, completed: 2 }
end
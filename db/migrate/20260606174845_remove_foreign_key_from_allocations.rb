class RemoveForeignKeyFromAllocations < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :allocations, :students, column: :student_id rescue nil
  end
end

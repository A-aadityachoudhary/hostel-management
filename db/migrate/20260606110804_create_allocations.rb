class CreateAllocations < ActiveRecord::Migration[8.1]
  def change
    create_table :allocations do |t|
      t.references :student, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date
      t.integer :status

      t.timestamps
    end
  end
end

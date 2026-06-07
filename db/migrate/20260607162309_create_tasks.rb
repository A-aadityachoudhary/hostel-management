class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :staff_id
      t.integer :admin_id

      t.timestamps
    end
  end
end

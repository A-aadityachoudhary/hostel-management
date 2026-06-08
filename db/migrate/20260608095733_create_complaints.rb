class CreateComplaints < ActiveRecord::Migration[8.1]
  def change
    create_table :complaints do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end

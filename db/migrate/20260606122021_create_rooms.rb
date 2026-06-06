class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.integer :capacity
      t.integer :floor
      t.references :block, null: false, foreign_key: true

      t.timestamps
    end
  end
end

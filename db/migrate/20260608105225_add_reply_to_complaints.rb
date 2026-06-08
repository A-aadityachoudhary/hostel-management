class AddReplyToComplaints < ActiveRecord::Migration[8.1]
  def change
    add_column :complaints, :reply, :text
  end
end

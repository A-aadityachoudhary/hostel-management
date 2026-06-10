# db/seeds.rb

# 1. Clear existing data in reverse order of dependency
Allocation.destroy_all
Task.destroy_all
Complaint.destroy_all
# Assuming Comment belongs to Complaint, clear them too if they exist
Comment.destroy_all 
Room.destroy_all
Block.destroy_all
User.destroy_all

# 2. Create Users
admin = User.create!(name: "Admin", email: "admin@hostel.com", password: "password", password_confirmation: "password", role: :admin)
student = User.create!(name: "John Doe", email: "john@student.com", password: "password", password_confirmation: "password", role: :student)

# 3. Create Blocks and Rooms
block = Block.create!(name: "Alpha Block", location: "East Wing")
Room.create!(room_number: "A101", capacity: 2, block: block)
Room.create!(room_number: "A102", capacity: 1, block: block)

puts "Database seeded successfully!"
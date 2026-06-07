# Clear existing data
Allocation.destroy_all
Room.destroy_all
Block.destroy_all
User.destroy_all

# Create Admin and Student
admin = User.create!(name: "Admin", email: "admin@hostel.com", password: "password", role: :admin)
student = User.create!(name: "John Doe", email: "john@student.com", password: "password", role: :student)

# Create Blocks and Rooms
block = Block.create!(name: "Alpha Block", location: "East Wing")
Room.create!(room_number: "A101", capacity: 2, block: block)
Room.create!(room_number: "A102", capacity: 1, block: block)

puts "Database seeded successfully!"
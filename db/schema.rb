# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_08_165053) do
  create_table "allocations", force: :cascade do |t|
    t.date "check_in_date"
    t.date "check_out_date"
    t.datetime "created_at", null: false
    t.integer "room_id", null: false
    t.integer "status"
    t.integer "student_id", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_allocations_on_room_id"
    t.index ["student_id"], name: "index_allocations_on_student_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "complaint_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["complaint_id"], name: "index_comments_on_complaint_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "complaints", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "message"
    t.text "reply"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_complaints_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "block_id", null: false
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.integer "floor"
    t.string "room_number"
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_rooms_on_block_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "staff_id"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "allocations", "rooms"
  add_foreign_key "comments", "complaints"
  add_foreign_key "comments", "users"
  add_foreign_key "complaints", "users"
  add_foreign_key "rooms", "blocks"
end

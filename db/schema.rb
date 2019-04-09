# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_08_222022) do

  create_table "accounts", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "archived", default: false
    t.string "reason"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "rides", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "depart_from"
    t.integer "account_id"
    t.string "departure"
    t.string "destination"
    t.string "start_date"
    t.string "end_date"
    t.string "start_time"
    t.string "end_time"
    t.integer "seats"
    t.float "departure_lat"
    t.float "departure_lon"
    t.float "destination_lat"
    t.float "destination_lon"
    t.index ["account_id"], name: "index_rides_on_account_id"
  end

end

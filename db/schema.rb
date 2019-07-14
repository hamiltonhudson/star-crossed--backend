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

ActiveRecord::Schema.define(version: 2019_07_11_053629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "compatibilities", force: :cascade do |t|
    t.bigint "sun_id"
    t.bigint "compatible_sun_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compatible_sun_id"], name: "index_compatibilities_on_compatible_sun_id"
    t.index ["sun_id", "compatible_sun_id"], name: "index_compatibilities_on_sun_id_and_compatible_sun_id", unique: true
    t.index ["sun_id"], name: "index_compatibilities_on_sun_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "message"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chat_id"
    t.index ["chat_id"], name: "index_conversations_on_chat_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "matched_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "matched"
    t.index ["matched_user_id"], name: "index_matches_on_matched_user_id"
    t.index ["user_id", "matched_user_id"], name: "index_matches_on_user_id_and_matched_user_id", unique: true
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "suns", force: :cascade do |t|
    t.string "sign"
    t.string "start_date"
    t.string "end_date"
    t.string "compat_signs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keywords"
    t.string "symbol"
    t.string "element"
    t.string "vibe"
    t.string "motto"
    t.string "glyph"
    t.string "good_traits"
    t.string "bad_traits"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birth_year"
    t.string "birth_month"
    t.string "birth_day"
    t.bigint "sun_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.string "gender_pref"
    t.integer "age"
    t.string "location"
    t.text "bio"
    t.string "photo"
    t.string "email"
    t.string "birth_date"
    t.string "password_digest"
    t.index ["sun_id"], name: "index_users_on_sun_id"
  end

  add_foreign_key "compatibilities", "suns"
  add_foreign_key "compatibilities", "suns", column: "compatible_sun_id"
  add_foreign_key "conversations", "chats"
  add_foreign_key "matches", "users"
  add_foreign_key "matches", "users", column: "matched_user_id"
  add_foreign_key "users", "suns"
end

# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131013220456) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkins", force: true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkins", ["place_id"], name: "index_checkins_on_place_id"
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id"

  create_table "initials", force: true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "accuracy"
    t.float    "altitudeAccuracy"
    t.float    "heading"
    t.float    "speed"
    t.integer  "error_code"
    t.datetime "timestamp"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id"

  create_table "my_maps", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "my_maps", ["user_id"], name: "index_my_maps_on_user_id"

  create_table "place_images", force: true do |t|
    t.integer  "place_id"
    t.binary   "data"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "place_images", ["place_id"], name: "index_place_images_on_place_id"

  create_table "places", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.float    "lat"
    t.float    "lng"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["category_id"], name: "index_places_on_category_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "way_points", force: true do |t|
    t.integer  "place_id"
    t.integer  "my_map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "way_points", ["my_map_id"], name: "index_way_points_on_my_map_id"
  add_index "way_points", ["place_id"], name: "index_way_points_on_place_id"

end

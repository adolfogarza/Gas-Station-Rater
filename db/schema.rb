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

ActiveRecord::Schema.define(version: 20140924212533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "station_id"
  end

  add_index "comments", ["station_id"], name: "index_comments_on_station_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "station_id"
  end

  add_index "locations", ["station_id"], name: "index_locations_on_station_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "honesty"
    t.integer  "speed_service"
    t.integer  "customer_service"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comment_id"
  end

  add_index "ratings", ["comment_id"], name: "index_ratings_on_comment_id", using: :btree

  create_table "stations", force: true do |t|
    t.string   "legal_name"
    t.integer  "counter_honesty"
    t.integer  "counter_speed_service"
    t.integer  "counter_customer_service"
    t.integer  "counter_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "lastname"
    t.integer  "privileges"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

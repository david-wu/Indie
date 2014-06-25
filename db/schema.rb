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

ActiveRecord::Schema.define(version: 20140625174553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "owner_id"
    t.string   "category"
    t.string   "img_src"
    t.string   "title"
    t.string   "description"
    t.integer  "funds_raised"
    t.integer  "funds_goal"
    t.string   "start"
    t.string   "end"
    t.string   "place"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
    t.string   "currency"
  end

  create_table "perks", force: true do |t|
    t.string   "title"
    t.integer  "cost"
    t.string   "currency"
    t.text     "description"
    t.integer  "claimed"
    t.integer  "available"
    t.string   "delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "img_src"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "fname",           null: false
    t.string   "lname",           null: false
    t.string   "password_digest"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

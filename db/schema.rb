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

ActiveRecord::Schema.define(version: 20140504095407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "messages", force: true do |t|
    t.boolean  "self_destruct"
    t.integer  "self_destruct_time"
    t.string   "self_destruct_type"
    t.string   "msg_type"
    t.integer  "room_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "msg_content"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "private"
    t.boolean  "message_scrub"
    t.string   "voting"
    t.boolean  "mms"
    t.datetime "last_post"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms_users", id: false, force: true do |t|
    t.integer "room_id"
    t.integer "user_id"
  end

  create_table "tribunals", force: true do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.integer  "votes_for"
    t.integer  "votes_against"
    t.integer  "total_votes"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "applicant_id"
    t.string   "title"
  end

  create_table "tribunals_users", force: true do |t|
    t.integer "tribunal_id"
    t.integer "user_id"
  end

  create_table "user_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "user_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "tribunal_id"
    t.boolean  "has_voted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

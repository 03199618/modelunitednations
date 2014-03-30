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

ActiveRecord::Schema.define(version: 20140329183025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: true do |t|
    t.text     "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
  end

  create_table "chairs", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comittees", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comittees_participants", id: false, force: true do |t|
    t.integer "comittee_id"
    t.integer "participant_id"
  end

  create_table "conference_managers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conferences", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
  end

  create_table "delegates", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delegations", force: true do |t|
    t.integer  "conference_id"
    t.text     "name"
    t.integer  "ambassador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pariticipant_roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_groups", force: true do |t|
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
  end

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
    t.integer  "delegation_id"
  end

  create_table "participants_comittees", id: false, force: true do |t|
    t.integer "participant_id"
    t.integer "comittee_id"
  end

  create_table "participants_participant_groups", id: false, force: true do |t|
    t.integer "participant_id"
    t.integer "participant_group_id"
  end

  create_table "participants_roles", id: false, force: true do |t|
    t.integer "participant_id"
    t.integer "role_id"
  end

  create_table "participants_roles_participants", id: false, force: true do |t|
    t.integer "participants_roles_id"
    t.integer "participants_id"
  end

  create_table "roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
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
    t.text     "name"
    t.text     "surname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

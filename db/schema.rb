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

ActiveRecord::Schema.define(version: 20140611203922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "announcements", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "announced_at_id"
    t.string   "announced_at_type"
    t.integer  "announcer_id"
    t.string   "announcer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committee_members", force: true do |t|
    t.integer  "committee_id"
    t.integer  "participant_id"
    t.integer  "committee_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committee_members_committee_roles", id: false, force: true do |t|
    t.integer "committee_role_id"
    t.integer "committee_member_id"
  end

  create_table "committee_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committee_sessions", force: true do |t|
    t.integer  "committee_id"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "committees", force: true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
    t.datetime "deadline_position_paper"
  end

  create_table "committees_participants", id: false, force: true do |t|
    t.integer "committee_id"
    t.integer "participant_id"
  end

  create_table "committees_topics", id: false, force: true do |t|
    t.integer "topic_id"
    t.integer "committee_id"
  end

  create_table "conference_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conferences", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.boolean  "public",            default: true
    t.text     "description"
    t.text     "acronym"
    t.text     "topic"
    t.text     "website_url"
    t.text     "organizer"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "city"
    t.text     "zipcode"
    t.text     "state"
    t.text     "country"
    t.text     "street"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "size"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "delegation_member_roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delegation_members", force: true do |t|
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delegation_id"
  end

  create_table "delegations", force: true do |t|
    t.integer  "conference_id"
    t.text     "name"
    t.integer  "ambassador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "timetable_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "group_registrations", force: true do |t|
    t.integer  "conference_id"
    t.integer  "participant_group_id"
    t.boolean  "withdrawn"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pariticipant_roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_group_members", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "participant_group_id"
  end

  create_table "participant_group_members_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "participant_group_member_id"
  end

  create_table "participant_group_roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_group_roles_participant_group_member", id: false, force: true do |t|
    t.integer "participant_group_member_id"
    t.integer "participant_group_role_id"
  end

  create_table "participant_groups", force: true do |t|
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.integer  "manager_id"
  end

  create_table "participant_groups_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "participant_group_id"
  end

  create_table "participant_roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
    t.integer  "delegation_id"
    t.integer  "participant_group_member_id"
  end

  create_table "participants_participant_groups", id: false, force: true do |t|
    t.integer "participant_id"
    t.integer "participant_group_id"
  end

  create_table "participants_participant_roles", id: false, force: true do |t|
    t.integer "participant_id"
    t.integer "participant_role_id"
  end

  create_table "registrations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conference_id"
    t.integer  "participant_group_member_id"
    t.boolean  "withdrawn"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.integer  "user_id"
    t.integer  "group_registration_id"
  end

  create_table "resolution_submitter_roles", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resolution_submitter_roles_resolution_submitters", id: false, force: true do |t|
    t.integer "resolution_submitter_id"
    t.integer "resolution_submitter_role_id"
  end

  create_table "resolution_submitters", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "delegate_id"
    t.integer  "resolution_id"
  end

  create_table "resolutions", force: true do |t|
    t.text     "content"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resolutions_delegates", id: false, force: true do |t|
    t.integer "delegate_id"
    t.integer "resolution_id"
  end

  create_table "resolutions_topics", id: false, force: true do |t|
    t.integer "topic_id"
    t.integer "resolution_id"
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

  create_table "timetables", force: true do |t|
    t.integer  "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
  end

  create_table "user_considerations", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                        default: "",   null: false
    t.string   "encrypted_password",           default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "firstname"
    t.text     "surname"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "intro",                        default: true
    t.float    "completeness"
    t.string   "timezone"
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string   "locale",                       default: "en"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

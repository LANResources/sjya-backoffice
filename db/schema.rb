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

ActiveRecord::Schema.define(version: 20131218174655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "item"
    t.string   "item_size"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sector_id"
  end

  add_index "organizations", ["sector_id"], name: "index_organizations_on_sector_id", using: :btree

  create_table "rapidfire_answers", force: true do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.text     "answer_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_answers", ["attempt_id"], name: "index_rapidfire_answers_on_attempt_id", using: :btree
  add_index "rapidfire_answers", ["question_id"], name: "index_rapidfire_answers_on_question_id", using: :btree

  create_table "rapidfire_attempts", force: true do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.date     "activity_date"
    t.text     "description"
    t.string   "completed_for", default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_attempts", ["survey_id"], name: "index_rapidfire_attempts_on_survey_id", using: :btree
  add_index "rapidfire_attempts", ["user_id"], name: "index_rapidfire_attempts_on_user_id", using: :btree

  create_table "rapidfire_questions", force: true do |t|
    t.integer  "survey_id"
    t.string   "section"
    t.string   "type"
    t.string   "question_text"
    t.integer  "position"
    t.text     "answer_options"
    t.text     "validation_rules"
    t.integer  "follow_up_for_id"
    t.text     "follow_up_for_condition"
    t.boolean  "allow_custom",            default: false
    t.string   "help_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rapidfire_questions", ["survey_id"], name: "index_rapidfire_questions_on_survey_id", using: :btree

  create_table "rapidfire_surveys", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sectors", ["name"], name: "index_sectors_on_name", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",             null: false
    t.string   "last_name",              null: false
    t.string   "email",                  null: false
    t.string   "password_digest"
    t.string   "title"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "invite_token"
    t.integer  "invited_by"
    t.datetime "invited_at"
    t.integer  "organization_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end

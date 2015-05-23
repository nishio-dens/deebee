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

ActiveRecord::Schema.define(version: 20150510150217) do

  create_table "projects", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.string   "key",          limit: 255, null: false
    t.string   "description",  limit: 255, null: false
    t.string   "creator_name", limit: 255
    t.string   "updater_name", limit: 255
    t.integer  "created_by",   limit: 4
    t.integer  "updated_by",   limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "deleted_at"
  end

  create_table "translation_histories", force: :cascade do |t|
    t.integer  "translation_id", limit: 4,     null: false
    t.string   "variable_name",  limit: 255,   null: false
    t.text     "ja",             limit: 65535, null: false
    t.text     "en",             limit: 65535, null: false
    t.integer  "project_id",     limit: 4,     null: false
    t.string   "creator_name",   limit: 255,   null: false
    t.string   "updater_name",   limit: 255,   null: false
    t.string   "changer_name",   limit: 255,   null: false
    t.integer  "created_by",     limit: 4,     null: false
    t.integer  "updated_by",     limit: 4,     null: false
    t.integer  "changed_by",     limit: 4,     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "changed_at",                   null: false
    t.datetime "deleted_at"
  end

  create_table "translations", force: :cascade do |t|
    t.string   "variable_name", limit: 255,   null: false
    t.text     "ja",            limit: 65535, null: false
    t.text     "en",            limit: 65535, null: false
    t.integer  "project_id",    limit: 4,     null: false
    t.string   "creator_name",  limit: 255,   null: false
    t.string   "updater_name",  limit: 255,   null: false
    t.integer  "created_by",    limit: 4,     null: false
    t.integer  "updated_by",    limit: 4,     null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 255,              null: false
    t.string   "email",              limit: 255, default: "", null: false
    t.string   "encrypted_password", limit: 255, default: "", null: false
    t.integer  "sign_in_count",      limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 255
    t.string   "last_sign_in_ip",    limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

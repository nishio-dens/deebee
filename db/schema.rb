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

ActiveRecord::Schema.define(version: 0) do

  create_table "columns", force: :cascade do |t|
    t.integer  "table_id",    limit: 4,                  null: false
    t.string   "column",      limit: 255,                null: false
    t.string   "column_type", limit: 255,                null: false
    t.integer  "length",      limit: 4
    t.string   "signed",      limit: 1,     default: "", null: false
    t.string   "binary",      limit: 1,     default: "", null: false
    t.string   "not_null",    limit: 1,     default: "", null: false
    t.string   "default",     limit: 255
    t.string   "key",         limit: 255
    t.text     "example",     limit: 65535
    t.string   "related",     limit: 255
    t.text     "comment",     limit: 65535
    t.text     "note",        limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "created_by",  limit: 4
    t.integer  "updated_by",  limit: 4
  end

  add_index "columns", ["table_id"], name: "columns_table_id_fk", using: :btree

  create_table "connection_settings", force: :cascade do |t|
    t.integer  "project_id", limit: 4,     null: false
    t.string   "adapter",    limit: 255,   null: false
    t.string   "database",   limit: 255,   null: false
    t.string   "username",   limit: 255,   null: false
    t.text     "password",   limit: 65535, null: false
    t.text     "host",       limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "connection_settings", ["project_id"], name: "connection_settings_project_id_fk", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer  "version_id",  limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tables", ["version_id"], name: "tables_version_id_fk", using: :btree

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

  create_table "versions", force: :cascade do |t|
    t.integer  "project_id",  limit: 4,     null: false
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "versions", ["project_id"], name: "versions_project_id_fk", using: :btree

  add_foreign_key "columns", "tables", name: "columns_table_id_fk"
  add_foreign_key "connection_settings", "projects", name: "connection_settings_project_id_fk"
  add_foreign_key "tables", "versions", name: "tables_version_id_fk"
  add_foreign_key "versions", "projects", name: "versions_project_id_fk"
end

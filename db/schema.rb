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

ActiveRecord::Schema.define(version: 20140702220220) do

  create_table "biomes", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "temp"
  end

  create_table "characters", force: true do |t|
    t.string   "FirstName"
    t.string   "Age"
    t.string   "Profession",   default: "0"
    t.string   "Race"
    t.string   "LastName"
    t.string   "Class"
    t.string   "Equipment",    default: "0"
    t.string   "Status",       default: "1"
    t.integer  "Strength",     default: 10
    t.integer  "Agility",      default: 10
    t.integer  "Intelligence", default: 10
    t.integer  "Stamina",      default: 10
    t.integer  "Curr_Stamina", default: 10
    t.integer  "Curr_Hp",      default: 10
    t.integer  "location"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["user_id"], name: "index_characters_on_user_id"

  create_table "guides", force: true do |t|
    t.string   "title"
    t.text     "msg"
    t.integer  "bind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "name"
    t.integer  "rate"
    t.string   "type"
    t.string   "info"
    t.string   "param"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "FamilyName"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "worlds", force: true do |t|
    t.string   "title"
    t.integer  "size"
    t.string   "connect"
    t.boolean  "hidden"
    t.boolean  "lock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "biome"
    t.string   "compass"
    t.string   "contain"
  end

end

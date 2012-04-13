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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120411003547) do

  create_table "coaches", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "phone_number"
    t.string    "email_address"
    t.integer   "division_id"
    t.integer   "team_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "divisions", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "sort_order"
    t.string    "color"
  end

  create_table "fields", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "games", :force => true do |t|
    t.timestamp "starts_at"
    t.integer   "visiting_team_id"
    t.integer   "home_team_id"
    t.integer   "field_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.integer   "division_id"
    t.integer   "team_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.date      "birthdate"
    t.string    "parents"
    t.string    "phone_number"
    t.string    "alternate_phone_number"
    t.string    "shirt_size"
  end

  create_table "teams", :force => true do |t|
    t.string    "name"
    t.integer   "division_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                         :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

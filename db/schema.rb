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

ActiveRecord::Schema.define(:version => 20130312205657) do

  create_table "collaborations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "log_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "collaborations", ["log_id"], :name => "index_collaborations_on_log_id"
  add_index "collaborations", ["user_id"], :name => "index_collaborations_on_user_id"

  create_table "log_items", :force => true do |t|
    t.integer  "log_id"
    t.integer  "user_id"
    t.integer  "position"
    t.string   "content"
    t.boolean  "milestone"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "desc"
    t.datetime "completed_at"
  end

  add_index "log_items", ["completed_at"], :name => "index_log_items_on_completed_at"
  add_index "log_items", ["log_id", "position"], :name => "index_log_items_on_log_id_and_position"
  add_index "log_items", ["log_id"], :name => "index_log_items_on_log_id"
  add_index "log_items", ["user_id"], :name => "index_log_items_on_user_id"

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "logs", ["user_id"], :name => "index_logs_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

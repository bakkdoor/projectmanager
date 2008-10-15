# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081015192933) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "house_nr"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "telephone"
    t.string   "email"
    t.string   "contact"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.date     "due_date"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects_users", :id => false, :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "user_id",    :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "parent_id"
    t.string   "name"
    t.text     "comment"
    t.integer  "status"
    t.date     "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks_users", :id => false, :force => true do |t|
    t.integer "task_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "tasks_worktimes", :id => false, :force => true do |t|
    t.integer "task_id",     :null => false
    t.integer "worktime_id", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "icq_im"
    t.string   "jabber"
    t.string   "telephone"
    t.string   "street"
    t.string   "house_nr"
    t.integer  "zip_code"
    t.string   "city"
    t.date     "birthdate"
    t.text     "comment"
    t.boolean  "is_admin"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "worktimes", :force => true do |t|
    t.integer  "user_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

end

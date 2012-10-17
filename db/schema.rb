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

ActiveRecord::Schema.define(:version => 20121017210623) do

  create_table "comment_votes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "form_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
    t.integer  "score"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["form_id", "created_at"], :name => "index_comments_on_form_id_and_created_at"

  create_table "form_downloads", :force => true do |t|
    t.integer  "form_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_requests", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "jurisdiction"
    t.string   "keywords"
    t.boolean  "anonymous"
    t.boolean  "fufilled"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  create_table "forms", :force => true do |t|
    t.string   "form"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.text     "description"
    t.string   "jurisdiction"
    t.string   "keywords"
    t.string   "name"
    t.integer  "sourcecomment_id"
  end

  create_table "inappropriate_documents", :force => true do |t|
    t.integer  "form_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "reason"
  end

  create_table "inappropriate_requests", :force => true do |t|
    t.integer  "request_id"
    t.integer  "user_id"
    t.text     "reason"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "request_submissions", :force => true do |t|
    t.integer  "form_id"
    t.integer  "form_request_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "comment"
    t.integer  "user_id"
    t.string   "ancestry"
  end

  add_index "request_submissions", ["ancestry"], :name => "index_request_submissions_on_ancestry"

  create_table "user_details", :force => true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.string   "website"
    t.text     "practice_area"
    t.text     "bio"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "show_comments"
    t.boolean  "show_uploaded"
    t.boolean  "show_downloaded"
    t.boolean  "show_requests"
  end

  create_table "user_feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.text     "subject"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_notifications", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "requests"
    t.boolean  "forms"
    t.boolean  "news"
    t.boolean  "tips"
    t.boolean  "surveys"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "verification_token"
    t.datetime "verification_token_sent_at"
    t.integer  "bar_number"
    t.string   "state_licensed"
    t.boolean  "verified"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end

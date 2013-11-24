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

ActiveRecord::Schema.define(:version => 20131124005440) do

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

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "form_downloads", :force => true do |t|
    t.integer  "form_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "form_permissions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "form_id"
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
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "practice_area_id"
  end

  create_table "form_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forms", :force => true do |t|
    t.string   "form"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.text     "description"
    t.string   "jurisdiction"
    t.string   "keywords"
    t.integer  "sourcecomment_id"
    t.boolean  "approved"
    t.integer  "practice_area_id"
    t.string   "origin"
    t.boolean  "seed"
  end

  create_table "forum_comment_votes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forum_comments", :force => true do |t|
    t.text     "content"
    t.integer  "forum_post_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "ancestry"
    t.integer  "score"
  end

  create_table "forum_posts", :force => true do |t|
    t.string   "title"
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "practice_areas", :force => true do |t|
    t.string   "practice_area_title"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "request_submissions", :force => true do |t|
    t.integer  "form_id"
    t.integer  "form_request_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "comment"
    t.integer  "user_id"
    t.boolean  "accepted"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "access_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "search_queries", :force => true do |t|
    t.integer  "user_id"
    t.text     "query"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shared_forms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "form_id"
    t.string   "email_address"
    t.string   "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_details", :force => true do |t|
    t.integer  "user_id"
    t.string   "location"
    t.string   "website"
    t.text     "practice_area"
    t.text     "bio"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "show_comments"
    t.boolean  "show_uploaded"
    t.boolean  "show_requests"
    t.boolean  "show_location"
    t.boolean  "show_website"
    t.boolean  "show_bio"
    t.boolean  "show_practice_area"
    t.boolean  "show_email"
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

  create_table "user_permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_practice_areas", :force => true do |t|
    t.integer  "user_id"
    t.integer  "practice_area_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
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
    t.datetime "last_signin_at"
    t.string   "referrer"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end

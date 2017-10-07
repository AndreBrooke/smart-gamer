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

ActiveRecord::Schema.define(version: 20171006124040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "badge_id"
    t.boolean "status", default: false
    t.integer "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["badge_id"], name: "index_achievements_on_badge_id"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.text "content"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.string "description"
    t.integer "goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commendations", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.integer "count", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_commendations_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "article_id"
    t.string "reply_article"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "follower_id"
    t.boolean "status", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_followers_on_status"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.boolean "vote_type", default: false
    t.integer "user_id"
    t.integer "commendation_id"
    t.index ["commendation_id"], name: "index_likes_on_commendation_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "playtimes", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "today_playtime", default: 0
    t.integer "total_playtime"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playtimes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "uid"
    t.string "nickname"
    t.string "avatar_url"
    t.string "profile_url"
    t.string "name"
    t.integer "personastate"
    t.integer "status", default: 0
    t.integer "privacy", default: 0
    t.integer "desired_playtime", default: 2
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "followers", "users"
  add_foreign_key "likes", "commendations"
  add_foreign_key "likes", "users"
end

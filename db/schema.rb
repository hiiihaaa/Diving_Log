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

ActiveRecord::Schema.define(version: 2020_05_24_155512) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "log_id", null: false
    t.text "comment_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "log_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["log_id"], name: "index_likes_on_log_id"
    t.index ["user_id", "log_id"], name: "index_likes_on_user_id_and_log_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "living_thing_imgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "log_id"
    t.string "l_img_file"
  end

  create_table "logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "diving_map"
    t.string "living_thing"
    t.text "description"
    t.date "d_date"
    t.string "weather_id"
    t.float "temp"
    t.integer "prefecture_id"
    t.string "address"
    t.float "w_temp"
    t.integer "visibility"
    t.string "current"
    t.integer "d_no"
    t.string "point"
    t.string "entry_method"
    t.time "entry_time"
    t.time "exit_time"
    t.integer "entry_air"
    t.integer "exit_air"
    t.integer "suits_id"
    t.integer "suits_thickness"
    t.float "weight"
    t.string "tank_type"
    t.integer "tank_volume"
    t.integer "likes_count", default: 0, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "photo"
    t.date "s_diving"
    t.text "self_introduction"
    t.integer "prefecture_id"
    t.integer "license"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

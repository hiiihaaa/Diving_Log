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

ActiveRecord::Schema.define(version: 2020_03_11_161033) do

  create_table "living_thing_imgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "log_id"
    t.string "l_img_file"
  end

  create_table "logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "map_file"
    t.string "living_thing"
    t.string "description"
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
    t.integer "suits_type_id"
    t.integer "suits_thickness"
    t.float "weight"
    t.string "tank_type"
    t.integer "tank_volume"
  end

end

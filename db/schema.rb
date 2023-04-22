# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_04_22_165723) do

  create_table "covid_reports", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.string "gender"
    t.integer "age"
    t.string "city"
    t.string "state"
    t.string "county"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.date "date"
    t.string "name"
    t.string "gender"
    t.integer "age"
    t.string "city"
    t.string "state"
    t.string "county"
    t.decimal "latitude", precision: 13, scale: 10
    t.decimal "longitude", precision: 13, scale: 10
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_06_03_131638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.integer "minimal_time_to_achieve"
    t.integer "time_to_reach_in_days"
    t.integer "time_to_reach_in_hours"
    t.integer "time_to_reach_in_minutes"
    t.bigint "goals_list_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goals_list_id"], name: "index_goals_on_goals_list_id"
  end

  create_table "goals_lists", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.boolean "is_public", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_goals_lists_on_user_id"
  end

  create_table "goals_steps", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.integer "minimal_time_to_achieve"
    t.integer "time_to_reach_in_days"
    t.integer "time_to_reach_in_hours"
    t.integer "time_to_reach_in_minutes"
    t.bigint "goals_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["goals_id"], name: "index_goals_steps_on_goals_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "role"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "first_login", default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end

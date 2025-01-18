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

ActiveRecord::Schema[7.0].define(version: 2025_01_18_165353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergency_kit_owners", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "age"
    t.integer "gender", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emergency_kit_owners_on_user_id"
  end

  create_table "emergency_kits", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "owner_id", null: false
    t.text "body"
    t.string "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_emergency_kits_on_owner_id"
    t.index ["user_id"], name: "index_emergency_kits_on_user_id"
  end

  create_table "kit_items", force: :cascade do |t|
    t.bigint "emergency_kit_id", null: false
    t.string "name"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emergency_kit_id"], name: "index_kit_items_on_emergency_kit_id"
  end

  create_table "stock_items", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.string "name"
    t.integer "quantity"
    t.string "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_stock_items_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "emergency_kit_owners", "users"
  add_foreign_key "emergency_kits", "emergency_kit_owners", column: "owner_id"
  add_foreign_key "emergency_kits", "users"
  add_foreign_key "kit_items", "emergency_kits"
  add_foreign_key "stock_items", "stocks"
  add_foreign_key "stocks", "users"
end

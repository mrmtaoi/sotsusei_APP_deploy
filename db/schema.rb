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

ActiveRecord::Schema[7.0].define(version: 2025_03_08_191843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_emergency_kits", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "emergency_kit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_emergency_kits_on_board_id"
    t.index ["emergency_kit_id"], name: "index_board_emergency_kits_on_emergency_kit_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.boolean "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.bigint "category_id"
    t.index ["category_id"], name: "index_kit_items_on_category_id"
    t.index ["emergency_kit_id"], name: "index_kit_items_on_emergency_kit_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kit_item_id"
    t.bigint "stock_item_id"
    t.bigint "emergency_kit_id"
    t.text "reminders"
    t.integer "interval_months"
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emergency_kit_id"], name: "index_reminders_on_emergency_kit_id"
    t.index ["kit_item_id"], name: "index_reminders_on_kit_item_id"
    t.index ["stock_item_id"], name: "index_reminders_on_stock_item_id"
    t.index ["user_id", "kit_item_id", "stock_item_id"], name: "index_reminders_on_user_kit_stock", unique: true
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "stock_items", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.string "name"
    t.integer "quantity"
    t.string "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_stock_items_on_category_id"
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
    t.string "share_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["share_token"], name: "index_users_on_share_token", unique: true
  end

  add_foreign_key "board_emergency_kits", "boards"
  add_foreign_key "board_emergency_kits", "emergency_kits"
  add_foreign_key "boards", "users"
  add_foreign_key "emergency_kit_owners", "users"
  add_foreign_key "emergency_kits", "emergency_kit_owners", column: "owner_id"
  add_foreign_key "emergency_kits", "users"
  add_foreign_key "kit_items", "categories"
  add_foreign_key "kit_items", "emergency_kits"
  add_foreign_key "reminders", "emergency_kits"
  add_foreign_key "reminders", "kit_items"
  add_foreign_key "reminders", "stock_items"
  add_foreign_key "reminders", "users"
  add_foreign_key "stock_items", "categories"
  add_foreign_key "stock_items", "stocks"
  add_foreign_key "stocks", "users"
end

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

ActiveRecord::Schema[8.1].define(version: 2026_01_14_170253) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "api_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "ip"
    t.string "refresh_token_digest", null: false
    t.datetime "revoked_at"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["expires_at"], name: "index_api_sessions_on_expires_at"
    t.index ["refresh_token_digest"], name: "index_api_sessions_on_refresh_token_digest", unique: true
    t.index ["user_id", "revoked_at"], name: "index_api_sessions_on_user_id_and_revoked_at"
    t.index ["user_id"], name: "index_api_sessions_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "brand"
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "license_plate"
    t.string "model"
    t.bigint "owner_id", null: false
    t.datetime "updated_at", null: false
    t.string "vin"
    t.integer "year"
    t.index ["owner_id"], name: "index_cars_on_owner_id"
  end

  create_table "contactors", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "bank_name"
    t.string "bik"
    t.string "checking_account"
    t.text "comment"
    t.string "contact_person"
    t.string "correspondent_account"
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "entity_type", null: false
    t.string "inn"
    t.string "kpp"
    t.string "legal_address"
    t.string "name", null: false
    t.string "phone"
    t.text "service_profile"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_contactors_on_active"
    t.index ["name"], name: "index_contactors_on_name"
    t.index ["phone"], name: "index_contactors_on_phone"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "ends_at"
    t.bigint "eventable_id"
    t.string "eventable_type"
    t.integer "kind", default: 0, null: false
    t.datetime "starts_at", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["eventable_type", "eventable_id"], name: "index_events_on_eventable"
  end

  create_table "expenses", force: :cascade do |t|
    t.decimal "amount", default: "0.0", null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.datetime "spent_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_item_performers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "order_item_id", null: false
    t.decimal "performer_fee", precision: 12, scale: 2, null: false
    t.bigint "performer_id", null: false
    t.string "performer_type", null: false
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id", "performer_type", "performer_id"], name: "idx_on_order_item_id_performer_type_performer_id_55a14ef11d", unique: true
    t.index ["order_item_id"], name: "index_order_item_performers_on_order_item_id"
    t.index ["performer_type", "performer_id"], name: "index_order_item_performers_on_performer"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.string "delivery_comment"
    t.decimal "delivery_price", precision: 12, scale: 2, default: "0.0", null: false
    t.string "materials_comment"
    t.decimal "materials_price", precision: 12, scale: 2, default: "0.0", null: false
    t.bigint "order_id", null: false
    t.boolean "paid", default: false, null: false
    t.decimal "performer_fee", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "price", precision: 12, scale: 2, default: "0.0", null: false
    t.bigint "service_id", null: false
    t.string "state", default: "initial", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_order_items_on_car_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["paid"], name: "index_order_items_on_paid"
    t.index ["service_id"], name: "index_order_items_on_service_id"
    t.index ["state"], name: "index_order_items_on_state"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "appointment_at"
    t.datetime "cancelled_at"
    t.bigint "client_id", null: false
    t.string "comment"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.decimal "expense", precision: 12, scale: 2, default: "0.0", null: false
    t.boolean "paid", default: false, null: false
    t.decimal "price", precision: 12, scale: 2, default: "0.0", null: false
    t.datetime "processing_at"
    t.string "state", default: "initial", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["paid"], name: "index_orders_on_paid"
    t.index ["state"], name: "index_orders_on_state"
  end

  create_table "services", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "duration_minutes"
    t.integer "popularity", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_services_on_active"
    t.index ["category"], name: "index_services_on_category"
    t.index ["slug"], name: "index_services_on_slug", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "value"
    t.string "variable"
    t.index ["variable"], name: "index_settings_on_variable", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.string "actual_address"
    t.string "additional_phone"
    t.string "bank_name"
    t.string "bik"
    t.string "checking_account"
    t.text "comment"
    t.string "company_name"
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.string "contact_person"
    t.string "contact_phone"
    t.string "correspondent_account"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "inn"
    t.string "kpp"
    t.string "last_name"
    t.string "legal_address"
    t.string "middle_name"
    t.string "ogrn"
    t.string "phone"
    t.integer "position", default: 0, null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.string "source"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "api_sessions", "users"
  add_foreign_key "cars", "users", column: "owner_id"
  add_foreign_key "order_item_performers", "order_items"
  add_foreign_key "order_items", "cars"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "services"
  add_foreign_key "orders", "users", column: "client_id"
end

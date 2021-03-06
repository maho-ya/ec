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

ActiveRecord::Schema.define(version: 2019_01_16_091826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "name", null: false
    t.datetime "display_start_datetime"
    t.datetime "display_end_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "general_settings", force: :cascade do |t|
    t.string "site_name", null: false
    t.string "postal_code"
    t.string "region"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "category_id"
    t.string "manufacture_name"
    t.string "code"
    t.bigint "tax_item_id", null: false
    t.integer "sales_price"
    t.integer "regular_price"
    t.integer "number_of_stocks"
    t.boolean "unlimited_stock", default: true, null: false
    t.datetime "display_start_datetime"
    t.datetime "display_end_datetime"
    t.string "description"
    t.string "search_term"
    t.string "jan_code"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["tax_item_id"], name: "index_products_on_tax_item_id"
  end

  create_table "slideshows", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "url"
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_items", force: :cascade do |t|
    t.string "name"
    t.integer "tax", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tax_rates", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.float "standard_tax_rate", default: 0.0, null: false
    t.float "reduced_tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["start_date"], name: "index_tax_rates_on_start_date", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "tax_items"
end

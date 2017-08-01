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

ActiveRecord::Schema.define(version: 20170708160209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "delivery_conditions", force: :cascade do |t|
    t.float    "order_deadlines", default: [],              array: true
    t.integer  "order_value_min", default: 0
    t.integer  "undelivery_days", default: [],              array: true
    t.datetime "holidays",        default: [],              array: true
    t.integer  "relation_id",                  null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["relation_id"], name: "index_delivery_conditions_on_relation_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.string   "document_type"
    t.boolean  "sent",          default: false
    t.integer  "order_id",                      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["order_id"], name: "index_documents_on_order_id", using: :btree
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "relation_id", null: false
    t.integer  "product_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_favorites_on_product_id", using: :btree
    t.index ["relation_id"], name: "index_favorites_on_relation_id", using: :btree
  end

  create_table "order_lines", force: :cascade do |t|
    t.float    "quantity"
    t.integer  "product_id", null: false
    t.integer  "order_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_lines_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_lines_on_product_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "delivery_date"
    t.string   "status",        default: "Validée"
    t.integer  "relation_id",                       null: false
    t.integer  "user_id",                           null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["relation_id"], name: "index_orders_on_relation_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "pricing_conditions", force: :cascade do |t|
    t.integer  "price"
    t.integer  "quantity_min", default: 0
    t.integer  "relation_id",              null: false
    t.integer  "product_id",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["product_id"], name: "index_pricing_conditions_on_product_id", using: :btree
    t.index ["relation_id"], name: "index_pricing_conditions_on_relation_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "reference"
    t.string   "public_price"
    t.string   "measuring_unit"
    t.string   "packaging"
    t.boolean  "is_discount",    default: false
    t.integer  "supplier_id",                    null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "role"
    t.integer  "user_id",       null: false
    t.integer  "restaurant_id"
    t.integer  "supplier_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["restaurant_id"], name: "index_profiles_on_restaurant_id", using: :btree
    t.index ["supplier_id"], name: "index_profiles_on_supplier_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "relations", force: :cascade do |t|
    t.integer  "restaurant_id", null: false
    t.integer  "supplier_id",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["restaurant_id"], name: "index_relations_on_restaurant_id", using: :btree
    t.index ["supplier_id"], name: "index_relations_on_supplier_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "locality"
    t.string   "phone_number"
    t.string   "siret"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "locality"
    t.string   "phone_number"
    t.string   "sector"
    t.string   "siret"
    t.boolean  "is_price_infos", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.boolean  "admin",                  default: false
    t.boolean  "is_supplier",            default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "delivery_conditions", "relations"
  add_foreign_key "documents", "orders"
  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "relations"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "order_lines", "products"
  add_foreign_key "orders", "relations"
  add_foreign_key "orders", "users"
  add_foreign_key "pricing_conditions", "products"
  add_foreign_key "pricing_conditions", "relations"
  add_foreign_key "products", "suppliers"
  add_foreign_key "profiles", "restaurants"
  add_foreign_key "profiles", "suppliers"
  add_foreign_key "profiles", "users"
  add_foreign_key "relations", "restaurants"
  add_foreign_key "relations", "suppliers"
end

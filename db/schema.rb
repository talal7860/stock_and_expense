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

ActiveRecord::Schema.define(version: 20170223110810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "username"
    t.string   "name"
    t.string   "phone_number"
    t.text     "address"
    t.boolean  "is_active",              default: true
    t.integer  "salary_cents",           default: 0,     null: false
    t.string   "salary_currency",        default: "USD", null: false
    t.integer  "share_percentage",       default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true, using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.text     "address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "company_transactions", force: :cascade do |t|
    t.string   "detail"
    t.integer  "transaction_type"
    t.integer  "amount_cents",      default: 0,     null: false
    t.string   "amount_currency",   default: "USD", null: false
    t.integer  "added_by_id"
    t.string   "transactable_type"
    t.integer  "transactable_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["added_by_id"], name: "index_company_transactions_on_added_by_id", using: :btree
  end

  create_table "company_wallets", force: :cascade do |t|
    t.string   "detail"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.integer  "added_by_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["added_by_id"], name: "index_company_wallets_on_added_by_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.text     "address"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "expense_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_expense_categories_on_slug", using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "name"
    t.integer  "added_by_id"
    t.integer  "expense_category_id"
    t.integer  "admin_user_id"
    t.integer  "amount_cents",        default: 0,     null: false
    t.string   "amount_currency",     default: "USD", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["added_by_id"], name: "index_expenses_on_added_by_id", using: :btree
    t.index ["admin_user_id"], name: "index_expenses_on_admin_user_id", using: :btree
    t.index ["expense_category_id"], name: "index_expenses_on_expense_category_id", using: :btree
  end

  create_table "skus", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "remaining",  default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stock_ins", force: :cascade do |t|
    t.integer  "sku_id"
    t.integer  "quantity"
    t.integer  "client_id"
    t.integer  "added_by_id"
    t.integer  "amount_cents",     default: 0,     null: false
    t.string   "amount_currency",  default: "USD", null: false
    t.date     "manufacture_date"
    t.date     "expiry_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["added_by_id"], name: "index_stock_ins_on_added_by_id", using: :btree
    t.index ["client_id"], name: "index_stock_ins_on_client_id", using: :btree
    t.index ["sku_id"], name: "index_stock_ins_on_sku_id", using: :btree
  end

  create_table "stock_outs", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "customer_id"
    t.integer  "sku_id"
    t.integer  "added_by_id"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["added_by_id"], name: "index_stock_outs_on_added_by_id", using: :btree
    t.index ["customer_id"], name: "index_stock_outs_on_customer_id", using: :btree
    t.index ["sku_id"], name: "index_stock_outs_on_sku_id", using: :btree
  end

end

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

ActiveRecord::Schema.define(version: 20161030144044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "total_price", precision: 13, scale: 2
    t.date     "since"
    t.boolean  "clear",                                default: false
    t.string   "picture"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "payee_name"
    t.string   "payee_contact"
    t.decimal  "contract_price",  precision: 13, scale: 2
    t.integer  "payment_type_id"
    t.boolean  "clear",                                    default: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "favours", force: :cascade do |t|
    t.integer  "contract_id"
    t.text     "description"
    t.boolean  "owner_agree", default: true
    t.boolean  "payee_agree", default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "items", force: :cascade do |t|
    t.integer  "bill_id"
    t.string   "item_name"
    t.decimal  "item_price", precision: 13, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "payment_types", force: :cascade do |t|
    t.string   "pay_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile_number"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end

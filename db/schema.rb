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

ActiveRecord::Schema[7.1].define(version: 2023_11_25_094830) do
  create_table "entities", force: :cascade do |t|
    t.integer "wallet_id"
    t.integer "system_user_id"
    t.string "type"
    t.string "name"
    t.date "birth_date"
    t.string "description"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["system_user_id"], name: "index_entities_on_system_user_id"
    t.index ["wallet_id"], name: "index_entities_on_wallet_id"
  end

  create_table "sytem_users", force: :cascade do |t|
    t.string "user_name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "source_wallet_id"
    t.integer "target_wallet_id"
    t.decimal "amount", precision: 10, scale: 2
    t.string "description"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_wallet_id"], name: "index_transactions_on_source_wallet_id"
    t.index ["target_wallet_id"], name: "index_transactions_on_target_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "entities", "system_users"
  add_foreign_key "entities", "wallets"
  add_foreign_key "transactions", "wallets", column: "source_wallet_id"
  add_foreign_key "transactions", "wallets", column: "target_wallet_id"
end

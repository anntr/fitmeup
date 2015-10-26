# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151026205557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.integer "measure"
    t.string  "modifier"
    t.string  "item"
    t.integer "product_id"
    t.integer "recipe_id"
  end

  add_index "ingredients", ["product_id"], name: "index_ingredients_on_product_id", using: :btree
  add_index "ingredients", ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "menus", ["user_id"], name: "index_menus_on_user_id", using: :btree

  create_table "menus_recipes", force: :cascade do |t|
    t.integer "menu_id"
    t.integer "recipe_id"
  end

  add_index "menus_recipes", ["menu_id"], name: "index_menus_recipes_on_menu_id", using: :btree
  add_index "menus_recipes", ["recipe_id"], name: "index_menus_recipes_on_recipe_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string  "name"
    t.integer "calories"
    t.float   "carbs"
    t.float   "lipids"
    t.float   "proteins"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.text     "instructions"
    t.string   "category",           default: [], array: true
    t.integer  "calories"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end

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

ActiveRecord::Schema.define(version: 20151113185310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "cook_stars"
    t.integer  "cook_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "cooks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "phone_number"
    t.boolean  "verified_phone",              default: false
    t.float    "lat"
    t.float    "lng"
    t.string   "formatted_address"
    t.string   "street_number"
    t.string   "route"
    t.string   "locality"
    t.float    "postal_code"
    t.string   "administrative_area_level_1"
    t.string   "country"
    t.string   "working_distance"
    t.text     "introduction"
    t.string   "gender"
    t.integer  "language1_id"
    t.integer  "language2_id"
    t.integer  "language3_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "cooks", ["user_id"], name: "index_cooks_on_user_id", using: :btree

  create_table "directions", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "rank"
    t.text     "step"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "directions", ["recipe_id"], name: "index_directions_on_recipe_id", using: :btree

  create_table "dishtypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "language"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "like_recipes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "like_recipes", ["recipe_id"], name: "index_like_recipes_on_recipe_id", using: :btree
  add_index "like_recipes", ["user_id"], name: "index_like_recipes_on_user_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "cook_id"
    t.string   "title"
    t.string   "intro"
    t.text     "description"
    t.integer  "dishtype_id"
    t.integer  "duration"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.float    "stars"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "recipes", ["cook_id"], name: "index_recipes_on_cook_id", using: :btree

  create_table "recipes_ingredients", id: false, force: :cascade do |t|
    t.integer "recipe_id",     null: false
    t.integer "ingredient_id", null: false
  end

  add_index "recipes_ingredients", ["recipe_id", "ingredient_id"], name: "index_recipes_ingredients_on_recipe_id_and_ingredient_id", unique: true, using: :btree

  create_table "recipes_materials", force: :cascade do |t|
    t.integer "recipe_id",   null: false
    t.integer "material_id", null: false
  end

  add_index "recipes_materials", ["recipe_id", "material_id"], name: "index_recipes_materials_on_recipe_id_and_material_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "pseudo"
    t.boolean  "registered",             default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

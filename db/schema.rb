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

ActiveRecord::Schema.define(version: 20161124123105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "media_items", force: :cascade do |t|
    t.string   "copyright_en"
    t.string   "copyright_cs"
    t.string   "source_url",      limit: 2048
    t.string   "photo_uid"
    t.string   "photo_name"
    t.string   "thumbnail_uid"
    t.string   "thumbnail_name"
    t.string   "type",                         default: "Image",    null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.text     "thumbnail_sizes",              default: "--- {}\n"
  end

  create_table "media_placements", force: :cascade do |t|
    t.string   "title_cs"
    t.string   "title_en"
    t.integer  "position"
    t.integer  "page_id"
    t.integer  "media_item_id"
    t.boolean  "is_plan"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "places", force: :cascade do |t|
    t.string   "title_cs"
    t.string   "title_en"
    t.string   "subtitle_cs"
    t.string   "subtitle_en"
    t.text     "text_content_en"
    t.text     "text_content_cs"
    t.text     "map_text_content_en"
    t.text     "map_text_content_cs"
    t.integer  "media_placements_count"
    t.string   "slug"
    t.string   "qr_id"
    t.decimal  "latitude",                            precision: 11, scale: 7
    t.decimal  "longitude",                           precision: 11, scale: 7
    t.string   "geo_coordinates"
    t.string   "address_cs",             limit: 1024
    t.string   "string",                 limit: 1024
    t.string   "address_en",             limit: 1024
    t.string   "era_cs"
    t.string   "era_en"
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.string   "type",                                                         default: "Place"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.string  "title_en"
    t.string  "title_cs"
    t.boolean "era",            default: false
    t.boolean "featured"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

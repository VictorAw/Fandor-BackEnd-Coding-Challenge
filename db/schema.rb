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

ActiveRecord::Schema.define(version: 20170224131330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "film_ratings", force: :cascade do |t|
    t.integer  "rating",     null: false
    t.integer  "film_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.index ["film_id", "user_id"], name: "index_film_ratings_on_film_id_and_user_id", unique: true, using: :btree
    t.index ["film_id"], name: "index_film_ratings_on_film_id", using: :btree
    t.index ["rating"], name: "index_film_ratings_on_rating", using: :btree
  end

  create_table "film_relations", force: :cascade do |t|
    t.integer  "origin_film_id",  null: false
    t.integer  "related_film_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["origin_film_id", "related_film_id"], name: "index_film_relations_on_origin_film_id_and_related_film_id", unique: true, using: :btree
    t.index ["origin_film_id"], name: "index_film_relations_on_origin_film_id", using: :btree
    t.index ["related_film_id", "origin_film_id"], name: "index_film_relations_on_related_film_id_and_origin_film_id", unique: true, using: :btree
    t.index ["related_film_id"], name: "index_film_relations_on_related_film_id", using: :btree
  end

  create_table "films", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "description", default: "N/A"
    t.string   "url_slug",                    null: false
    t.integer  "year",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["url_slug"], name: "index_films_on_url_slug", unique: true, using: :btree
  end

end

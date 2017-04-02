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

ActiveRecord::Schema.define(version: 20170402061751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "nom"
    t.float    "prix"
    t.integer  "quantite"
    t.integer  "liste_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["liste_id"], name: "index_articles_on_liste_id", using: :btree
  end

  create_table "listes", force: :cascade do |t|
    t.string   "nom"
    t.integer  "takenby"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_listes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "nom"
    t.string   "prenom"
    t.string   "email"
    t.string   "notel"
    t.string   "passwd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

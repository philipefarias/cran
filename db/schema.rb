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

ActiveRecord::Schema.define(version: 20150704160048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "version",     null: false
    t.date     "publication", null: false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "packages_authors", id: false, force: :cascade do |t|
    t.integer "package_id", null: false
    t.integer "person_id",  null: false
  end

  add_index "packages_authors", ["package_id"], name: "index_packages_authors_on_package_id", using: :btree
  add_index "packages_authors", ["person_id"], name: "index_packages_authors_on_person_id", using: :btree

  create_table "packages_maintainers", id: false, force: :cascade do |t|
    t.integer "package_id", null: false
    t.integer "person_id",  null: false
  end

  add_index "packages_maintainers", ["package_id"], name: "index_packages_maintainers_on_package_id", using: :btree
  add_index "packages_maintainers", ["person_id"], name: "index_packages_maintainers_on_person_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

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

ActiveRecord::Schema.define(version: 20160421093225) do

  create_table "daily_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "dimension_id",            null: false
    t.string  "date",                    null: false
    t.float   "value",        limit: 24, null: false
    t.index ["dimension_id", "date"], name: "index_daily_records_on_dimension_id_and_date", unique: true, using: :btree
  end

  create_table "dimensions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "metric_id",   null: false
    t.integer "cardinality", null: false
    t.string  "group",       null: false
    t.string  "key",         null: false
    t.index ["metric_id", "cardinality", "group"], name: "index_dimensions_on_metric_id_and_cardinality_and_group", using: :btree
    t.index ["metric_id", "key"], name: "index_dimensions_on_metric_id_and_key", unique: true, using: :btree
  end

  create_table "metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "namespace_id", null: false
    t.string  "name",         null: false
    t.index ["namespace_id", "name"], name: "index_metrics_on_namespace_id_and_name", unique: true, using: :btree
  end

  create_table "namespaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_namespaces_on_name", unique: true, using: :btree
  end

end

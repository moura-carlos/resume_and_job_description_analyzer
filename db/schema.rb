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

ActiveRecord::Schema[7.1].define(version: 2024_06_30_015159) do
  create_table "analyses", force: :cascade do |t|
    t.text "content"
    t.integer "analyzer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "matching_skills"
    t.text "missing_skills"
    t.decimal "match_score"
    t.text "ats_tips"
    t.index ["analyzer_id"], name: "index_analyses_on_analyzer_id"
  end

  create_table "analyzers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_descriptions", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "analyzer_id", null: false
    t.index ["analyzer_id"], name: "index_job_descriptions_on_analyzer_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "analyzer_id", null: false
    t.index ["analyzer_id"], name: "index_resumes_on_analyzer_id"
  end

  add_foreign_key "analyses", "analyzers"
  add_foreign_key "job_descriptions", "analyzers"
  add_foreign_key "resumes", "analyzers"
end

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

ActiveRecord::Schema[8.0].define(version: 2024_12_18_014947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedback_responses", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "corporate_email"
    t.string "location"
    t.string "company_tenure"
    t.string "gender"
    t.string "generation"
    t.string "company_level_0"
    t.string "directorate_level_1"
    t.string "management_level_2"
    t.string "coordination_level_3"
    t.string "area_level_4"
    t.date "response_date"
    t.integer "interest_in_position"
    t.text "comments_interest_in_position"
    t.integer "contribution"
    t.text "comments_contribution"
    t.integer "learning_and_development"
    t.text "comments_learning_and_development"
    t.integer "feedback"
    t.text "comments_feedback"
    t.integer "interaction_with_manager"
    t.text "comments_interaction_with_manager"
    t.integer "clarity_about_career_opportunities"
    t.text "comments_clarity_about_career_opportunities"
    t.integer "expectation_of_permanence"
    t.text "comments_expectation_of_permanence"
    t.integer "employee_net_promoter_score"
    t.text "open_comments_enps"
    t.bigint "department_id", null: false
    t.bigint "position_id", null: false
    t.bigint "function_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_feedback_responses_on_department_id"
    t.index ["function_id"], name: "index_feedback_responses_on_function_id"
    t.index ["position_id"], name: "index_feedback_responses_on_position_id"
  end

  create_table "functions", force: :cascade do |t|
    t.string "name"
    t.bigint "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position_id"], name: "index_functions_on_position_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "name"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_positions_on_department_id"
  end

  add_foreign_key "feedback_responses", "departments"
  add_foreign_key "feedback_responses", "functions"
  add_foreign_key "feedback_responses", "positions"
  add_foreign_key "functions", "positions"
  add_foreign_key "positions", "departments"
end

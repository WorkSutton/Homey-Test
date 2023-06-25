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

ActiveRecord::Schema[7.0].define(version: 2023_06_23_094123) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "tracking_status", ["draft", "pending", "in_progress", "awaiting_information", "awaiting_approval", "approved", "overdue", "cancelled", "completed"]

  create_table "comments", force: :cascade do |t|
    t.text "detail", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_comments_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "tracking_status", enum_type: "tracking_status"
    t.index ["tracking_status"], name: "index_projects_on_tracking_status"
  end

  create_table "tracking_status_histories", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.enum "tracking_status", null: false, enum_type: "tracking_status"
    t.datetime "history_started_at", precision: nil, null: false
    t.datetime "history_ended_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tracking_status_histories_on_project_id"
    t.index ["tracking_status"], name: "index_tracking_status_histories_on_tracking_status"
  end

  add_foreign_key "comments", "projects"
  add_foreign_key "tracking_status_histories", "projects"
end

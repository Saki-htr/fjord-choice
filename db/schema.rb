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

ActiveRecord::Schema[7.0].define(version: 2022_08_04_114048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigned_issues", force: :cascade do |t|
    t.bigint "raw_issue_id", null: false
    t.integer "point", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_issue_id"], name: "index_assigned_issues_on_raw_issue_id"
  end

  create_table "raw_issues", force: :cascade do |t|
    t.jsonb "issue", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_assigned_issues", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assigned_issues_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_issues_id"], name: "index_user_assigned_issues_on_assigned_issues_id"
    t.index ["user_id"], name: "index_user_assigned_issues_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "github_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "assigned_issues", "raw_issues"
  add_foreign_key "user_assigned_issues", "assigned_issues", column: "assigned_issues_id"
  add_foreign_key "user_assigned_issues", "users"
end
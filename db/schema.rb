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

ActiveRecord::Schema[7.0].define(version: 2022_09_13_084611) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigned_issues", force: :cascade do |t|
    t.integer "point", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number", null: false
    t.integer "assignees", default: [], null: false, array: true
    t.index ["assignees"], name: "index_assigned_issues_on_assignees"
    t.index ["number"], name: "index_assigned_issues_on_number", unique: true
  end

  create_table "review_requested_pull_requests", force: :cascade do |t|
    t.string "title", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", null: false
    t.integer "reviewers", default: [], null: false, array: true
    t.index ["number"], name: "index_review_requested_pull_requests_on_number", unique: true
    t.index ["reviewers"], name: "index_review_requested_pull_requests_on_reviewers"
  end

  create_table "user_assigned_issues", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assigned_issue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_issue_id"], name: "index_user_assigned_issues_on_assigned_issue_id"
    t.index ["user_id", "assigned_issue_id"], name: "index_user_assigned_issues_on_user_id_and_assigned_issue_id", unique: true
    t.index ["user_id"], name: "index_user_assigned_issues_on_user_id"
  end

  create_table "user_pull_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_requested_pull_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_requested_pull_request_id"], name: "index_user_pull_requests_on_review_requested_pull_request_id"
    t.index ["user_id", "review_requested_pull_request_id"], name: "index_user_pull_requests_on_user_id_and_pull_request_id", unique: true
    t.index ["user_id"], name: "index_user_pull_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "provider", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url", null: false
    t.integer "uid", null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "user_assigned_issues", "assigned_issues"
  add_foreign_key "user_assigned_issues", "users"
  add_foreign_key "user_pull_requests", "review_requested_pull_requests"
  add_foreign_key "user_pull_requests", "users"
end

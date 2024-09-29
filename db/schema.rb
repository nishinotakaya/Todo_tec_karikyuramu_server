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

ActiveRecord::Schema[7.1].define(version: 2024_09_03_145831) do
  create_table "todos", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "content"
    t.boolean "completed"
    t.boolean "delete_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort"
    t.string "sub_content", limit: 10000
    t.date "output_date"
    t.integer "progress_rate"
    t.date "start_date"
    t.date "completion_date"
    t.date "completion_date_actual"
    t.integer "copy_id"
    t.index ["copy_id"], name: "index_todos_on_copy_id"
  end

end

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

ActiveRecord::Schema[7.0].define(version: 2023_09_08_183032) do
  create_table "appointments", force: :cascade do |t|
    t.integer "start_at"
    t.integer "ends_at"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "doctor_id"
    t.integer "patient_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "#<ActiveRecord::ConnectionAdapters::SQLite3::TableDefinition:0x0000560206f510a0>"
    t.integer "appointment_id"
    t.index ["appointment_id"], name: "index_patients_on_appointment_id"
  end

  create_table "working_days", force: :cascade do |t|
    t.string "day"
    t.integer "start_at"
    t.integer "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "doctor_id"
    t.index ["doctor_id"], name: "index_working_days_on_doctor_id"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "patients", "appointments"
  add_foreign_key "working_days", "doctors"
end

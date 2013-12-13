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

ActiveRecord::Schema.define(version: 20131213005451) do

  create_table "assessments", force: true do |t|
    t.integer  "subject_id"
    t.string   "type_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term"
  end

  create_table "averages", force: true do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.float    "t1"
    t.float    "t2"
    t.float    "t3"
    t.float    "t4"
    t.float    "exams_s1"
    t.float    "exams_s2"
    t.boolean  "overall"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.integer  "student_id"
    t.integer  "assessment_id"
    t.decimal  "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer  "house"
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "email"
    t.integer  "class_group"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.boolean  "elective"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

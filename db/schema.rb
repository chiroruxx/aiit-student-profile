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
# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2022_01_20_122214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'subjects', force: :cascade do |t|
    t.string 'name', limit: 128, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'user_profile_subjects', force: :cascade do |t|
    t.bigint 'user_profile_id', null: false
    t.bigint 'subject_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['subject_id'], name: 'index_user_profile_subjects_on_subject_id'
    t.index ['user_profile_id'], name: 'index_user_profile_subjects_on_user_profile_id'
  end

  create_table 'user_profiles', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'name', limit: 128, null: false
    t.string 'name_kana', limit: 128
    t.string 'nickname', limit: 128
    t.string 'email', limit: 255, null: false
    t.string 'major_subject', limit: 255, null: false
    t.integer 'started', limit: 2, null: false
    t.text 'work'
    t.text 'background'
    t.text 'hobby'
    t.string 'pbl', limit: 128
    t.string 'favorite_food', limit: 128
    t.string 'hated_food', limit: 128
    t.text 'other'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'image'
    t.index ['user_id'], name: 'index_user_profiles_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', limit: 128, null: false
    t.string 'provider', limit: 128, null: false
    t.string 'uid', limit: 36, null: false
    t.string 'email', limit: 255, null: false
    t.string 'image'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'user_profile_subjects', 'subjects'
  add_foreign_key 'user_profile_subjects', 'user_profiles'
  add_foreign_key 'user_profiles', 'users'
end

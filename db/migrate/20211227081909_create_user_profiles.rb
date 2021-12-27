# frozen_string_literal: true

# CreateUserProfiles is a migration class generated by ActiveRecord
class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, null: false, limit: 128
      t.string :name_kana, null: false, limit: 128
      t.string :nickname, null: false, limit: 128
      t.string :email, null: false, limit: 255
      t.string :major_subject, null: false, limit: 255
      t.string :started, null: false, limit: 4
      t.text :work
      t.text :background
      t.text :hobby
      t.string :pbl, limit: 128
      t.string :favorite_food, limit: 128
      t.string :hated_food, limit: 128
      t.text :other
      t.timestamps
    end
  end
end

# frozen_string_literal: true

# CreateSubjects is a migration class generated by ActiveRecord
class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name, null: false, limit: 128
      t.timestamps
    end
  end
end

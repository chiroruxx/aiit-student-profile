# frozen_string_literal: true
# CreateUsers is a migration class generated by ActiveRecord
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateUsersHistoryRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :users_history_records do |t|
      t.string :operation_type, null: false
      t.float :amount, null: false
      t.float :balance_after, null: false

      t.timestamps
    end
  end
end

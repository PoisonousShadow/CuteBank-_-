# frozen_string_literal: true

class AddForeignKeyUserHistoryUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users_history_records, :user_id, :bigint
    add_foreign_key :users_history_records, :users
  end
end

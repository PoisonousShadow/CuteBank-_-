# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.float :current_balance, default: 0.0, null: false
      t.boolean :user_is_admin, null: false

      t.timestamps
    end
  end
end

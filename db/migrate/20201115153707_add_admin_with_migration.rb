# frozen_string_literal: true

class AddAdminWithMigration < ActiveRecord::Migration[6.0]
  def change
    User.create user_is_admin: true, email: 'trueadmin@google.com', password: '123456', password_confirmation: '123456'
  end
end

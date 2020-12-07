# frozen_string_literal: true

class AddAdminUser < ActiveRecord::Migration[6.0]
  def change
    User.create user_is_admin: true, email: 'admin@admin.com', :password => "123456"
  end
end

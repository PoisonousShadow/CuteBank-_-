# frozen_string_literal: true

class DeleteNotNeedpaswordGetAdminDefault < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :password
    change_column :users, :user_is_admin, :boolean, default: false
  end
end

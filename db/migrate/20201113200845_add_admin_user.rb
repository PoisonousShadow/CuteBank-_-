class AddAdminUser < ActiveRecord::Migration[6.0]
  def change
    User.create :user_is_admin => true, :email => 'admin@admin.com'
  end
end

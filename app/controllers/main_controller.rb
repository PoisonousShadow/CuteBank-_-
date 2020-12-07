# frozen_string_literal: true

class MainController < ApplicationController
  before_action :check_user

  def index; end

  # redirecting admin to admin user page and user to user main page,
  # for not getting error while trying to access '/' and 'main'
  # in case of authenticated users
  def check_user
    unless current_user.nil?
      if current_user.user_is_admin?
        redirect_to controller: 'admin', action: 'index'
      else
        redirect_to controller: 'user', action: 'index'
      end
    end
  end
end

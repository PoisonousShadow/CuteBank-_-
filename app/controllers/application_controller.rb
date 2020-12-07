# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(_resource)
    user_index_path
  end

  def after_sign_out_path_for(_resource)
    main_index_path
  end

  def require_admin
    unless current_user&.user_is_admin
      flash[:error] = 'You are not an admin'

      redirect_to user_index_path
    end
  end
end

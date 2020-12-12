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

  def check_input(input)
    allowed_pattern = /(^\d+[.|,]\d{2}$)|(^\d+$)|(^\d+[.|,]\d{1}$)|(^\d+[.|,]\d{2}e\+\d+$)|(^\d+[.|,]\d{1}e\+\d+$)/

    if input.to_s.match?(allowed_pattern)
      amount = input.to_f

      case amount

      when 0.0
        'Input of zero wil have no effect!'

      when amount < 0.0
        'Input of negative numbers is not allowed!'

      when Float::INFINITY
        'A liar is detected! It is impossible for you to have such sum of money nowadays!'

      else
        nil

      end

    else
      'Wrong intput format!'

    end
  end
end

# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin

  def index
    @user = User.find(current_user.id)

    @record = @user.users_history_record.all
  end

  def create
    @user = User.find(current_user.id)

    @record = @user.users_history_record.all

    unless params[:commit].nil?
      if choose_action
        redirect_to '/user'

      else
        render 'index'

      end

    end
  end

  # choosing what action to do depending on :commit value
  private

  def choose_action
    hash = params.require(:user).permit(:current_balance, :commit)
    hash[:commit] = params[:commit]
    result = check_input(hash[:current_balance])
    if result.nil?
      hash[:current_balance] = hash[:current_balance].to_f

      operate(hash)

    else
      User.add_errors(result, @user)
    end
  end

  def operate(hash)
    @user = User.find(current_user.id)

    if User.operate(hash, @user)
      @record = @user.users_history_record.build(operation_type: hash[:commit], amount: hash[:current_balance], balance_after: @user.current_balance)

      @record.save! ? true : false

    else
      false

    end
  end

  # redirecting admin user to admin page

  def check_if_admin
    redirect_to controller: 'admin', action: 'index' if current_user.user_is_admin?
  end
end

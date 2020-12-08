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
      if !choose_action
        render 'index'
      else
        redirect_to '/user'
      end
    end
  end

  def deposit(amount)
    @user = User.find(current_user.id)

    if User.deposit(amount, @user)
      CashMachine.add_cash(amount)

      @record = @user.users_history_record.build(operation_type: 'Deposit', amount: amount, balance_after: @user.current_balance)

      @record.save ? true : false
    else
      false
    end
  end

  def withdraw(amount)
    @user = User.find(current_user.id)

    if User.withdraw(amount, @user)
      @record = @user.users_history_record.build(operation_type: 'Withdraw', amount: amount, balance_after: @user.current_balance)

      @record.save ? true : false
    else
      false
    end
  end

  # choosing what action to do depending on :commit value
  private

  def choose_action
    hash = params.require(:user).permit(:current_balance, :commit)
    hash[:commit] = params[:commit]
    sum_int = hash[:current_balance].to_f

    case hash[:commit]
    when 'Withdraw'
      withdraw(sum_int)
    when 'Deposit'
      deposit(sum_int)
    end
  end

  # redirecting admin user to admin page

  def check_if_admin
    redirect_to controller: 'admin', action: 'index' if current_user.user_is_admin?
  end
end

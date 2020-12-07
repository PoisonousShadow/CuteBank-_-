# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @cash = CashMachine.find(1)
  end

  def create
    @cash = CashMachine.find(1)

    unless params[:commit].nil?
      hash = params.require(:admin).permit(:cash_amount)
      cash_amount = hash[:cash_amount].to_f

      CashMachine.update_cash(cash_amount, @cash)

      render 'index'
    end
  end
end

# frozen_string_literal: true

class AddCashMachineOne < ActiveRecord::Migration[6.0]
  def change
    CashMachine.create
  end
end

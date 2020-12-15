# frozen_string_literal: true

class CashMachine < ApplicationRecord
  validates :cash_amount, presence: true

  def self.add_cash(amount)
    @machine = CashMachine.find(1)
    new_amount = (@machine.cash_amount + amount)

    if [Float::INFINITY, Float::MAX].include?(new_amount)
      false

    else
      @machine.cash_amount = new_amount
      @machine.save!

      true

    end
  end

  # check if operation can be gone throuth and cash_machine balance won't be lower than zero
  def self.cash_available?(amount)
    @machine = CashMachine.find(1)

    new_amount = (@machine.cash_amount - amount)

    if new_amount < 0.0
      false

    else
      @machine.cash_amount = new_amount
      @machine.save!

      true

    end
  end

  # custom method to update cash_amount in cash_machine to receive error notifications
  def self.update_cash(amount, cash)
    cash.cash_amount =  amount

    cash.save! ? true : false
  end
end

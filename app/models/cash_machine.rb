# frozen_string_literal: true

class CashMachine < ApplicationRecord
  validates :cash_amount, presence: true

  def self.add_cash(amount)
    machine = CashMachine.find(1)

    machine.cash_amount = (machine.cash_amount += amount).round(2)

    machine.save!
  end

  # check if operation can be gone throuth and cash_machine balance won't be lower than zero
  def self.cash_available?(amount, user)
    machine = CashMachine.find(1)
    new_cash = (machine.cash_amount - amount).round(2)

    if new_cash < 0.0
      user.errors.add(:cash_machine, "The Cash machine doesn't have such sum")
      false
    else
      machine.cash_amount = new_cash
      machine.save!

      true
    end
  end

  # custom method to update cash_amount in cash_machine to receive error notifications
  def self.update_cash(amount, cash)
    if greater_or_equal_to_zero?(amount)
      cash.cash_amount = amount
      cash.save!

      true
    else
      cash.errors.add(:input, "can't be lower than zero!")
      false
    end
  end

  def self.greater_or_equal_to_zero?(amount)
    amount >= 0
  end
end

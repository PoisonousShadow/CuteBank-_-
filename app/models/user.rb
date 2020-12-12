# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  has_many :users_history_record, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :current_balance, presence: true

  def self.operate(hash, user)
    case hash[:commit]

    when 'Withdraw'
      withdraw(hash[:current_balance], user)

    when 'Deposit'
      deposit(hash[:current_balance], user)

    else
      add_errors('Not a withdraw or deposit', user)

      false

    end
  end

  def self.withdraw(amount, user)
    substraction_result = user.current_balance - amount

    if substraction_result >= 0.0
      if CashMachine.cash_available?(amount)
        user.current_balance = substraction_result
        user.save! ? true : false

      else
        user.errors.add(:input, 'Cash mashine does not contain such sum!')

        false

      end

    else
      user.errors.add(:input, 'Your balance will be lower than zero after this operation!')
      false

    end
  end

  def self.deposit(amount, user)
    if CashMachine.add_cash(amount)
      user.current_balance += amount
      user.save! ? true : false

    else
      user.errors.add(:input, "Cash machine can't store the sum expected after this operation")

    end
  end

  def self.add_errors(error, user)
    if !error.nil?
      user.errors.add(:input, error)
      false

    else
      true

    end
  end
end

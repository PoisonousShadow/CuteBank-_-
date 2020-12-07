# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models

  has_many :users_history_record

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :current_balance, presence: true

  def self.deposit(amount, user)
    if input_valid?(amount, user)
      user.current_balance = (user.current_balance += amount).round(2)
      user.save!

      true
    else
      false
    end
  end

  def self.withdraw(amount, user)
    if input_valid?(amount, user) && CashMachine.cash_available?(amount, user)
      user.current_balance = (user.current_balance -= amount).round(2)
      user.save!

      true
    else
      false
    end
  end

  def self.input_valid?(amount, user)
    if amount < 0.0
      user.errors.add(:input, "Number can't be lower than zero")

      false
    elsif amount == 0.0
      user.errors.add(:input, 'Adding or substracting zero will have no power')

      false
    else
      true
    end
  end
end

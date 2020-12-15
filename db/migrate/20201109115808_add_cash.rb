class AddCash < ActiveRecord::Migration[6.0]
  def change
    CashMachine.create
  end
end

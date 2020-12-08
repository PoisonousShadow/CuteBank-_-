# frozen_string_literal: true

class CreateCashMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_machines do |t|
      t.float :cash_amount, default: 100_000.0, null: false

      t.timestamps
    end
  end
end

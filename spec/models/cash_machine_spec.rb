require 'rails_helper'

RSpec.describe CashMachine, type: :model do
  before(:all) do
    @cash_machine = CashMachine.create(id: 1)

    @u = User.new(email: 'user@gmail.com', password: '123456')

    expect(@u.valid?).to eq(true)
  end

  after(:all) do
    @cash_machine.destroy
    @u.destroy
  end

  context 'create cash_machine' do
    it 'is expected to create succesfully' do
      expect(@cash_machine).to be_valid
    end

    it 'is expected to not create succesfully' do
      @cash_machine.cash_amount = 'sdasd'
      expect(@cash_machine.cash_amount).to eq(0.0)
    end
  end
  context 'add_cash' do
    max = Float::MAX

    it 'is expected not to add max float to cash machine' do
      @cash_machine.cash_amount = 1000.0
      @cash_machine.save!

      expect(CashMachine.add_cash(max)).to eq(false)
    end

    it 'is expected not to add if cash_machine is max' do
      @cash_machine.cash_amount = max
      @cash_machine.save!

      expect(CashMachine.add_cash(1000.0)).to eq(false)
    end

    it 'is expecteed to return true' do
      @cash_machine.cash_amount = 1000.0
      @cash_machine.save!

      expect(CashMachine.add_cash(123.0)).to eq(true)
    end
  end

  context 'cash_available?' do
    it 'is expected to fail if (cash_amout - amout) < 0.0' do
      @cash_machine.cash_amount = 10.0
      @cash_machine.save!

      expect(CashMachine.cash_available?(20.0)).to eq(false)
    end

    it 'is expected to fail if amout < 0.0' do
      @cash_machine.cash_amount = 0.0
      @cash_machine.save!

      expect(CashMachine.cash_available?(-20.0)).to eq(true)
    end
  end

  context 'update_cash' do
    it 'is expected not to save if wrong input' do
      expect(CashMachine.update_cash(-213, @cash_machine)).to eq(true)
    end

    it 'is expected to save if rigth input' do
      expect(CashMachine.update_cash(213.0, @cash_machine)).to eq(true)
    end
  end
end

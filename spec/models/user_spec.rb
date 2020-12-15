require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @_amount = -2
    @cash_machine = CashMachine.create(id: 1)
    @u = User.new(email: 'user@gmail.com', password: '123456')

    expect(@u.valid?).to eq(true)
  end

  after(:all) do
    @u.destroy
    @cash_machine.destroy
  end

  context 'operate' do
    it 'is expected to fail if hash[:commit] is not Withdraw or Deposit' do
      @u = create :user

      hash = {}
      hash[:commit] = 'sdfsdfsdf'

      expect(User.operate(hash, @u)).to eq(false)
    end

    it 'is expected return true if withdraw and not normal input' do
      @u = create :user

      hash = {}
      hash[:commit] = 'Withdraw'
      hash[:current_balance] = 23.0

      expect(User.operate(hash, @u)).to eq(false)
    end

    it 'is expected return true if deposit and normal input' do
      @u = create :user

      hash = {}
      hash[:commit] = 'Deposit'
      hash[:current_balance] = 23.0

      expect(User.operate(hash, @u)).to eq(true)
    end
  end

  context 'withdraw' do
    it 'is expected ot fail if (user.current_balance - input) < 0.0' do
      @u = create :user
      @u.current_balance = 300.0
      @u.save!

      expect(User.withdraw(300.01, @u)).to eq(false)
    end

    it 'is expected ot return true if cash_available == true' do
      @u = create :user
      @u.current_balance = 300.0
      @u.save!

      User.withdraw(20.0, @u)
      expect(@u.errors).to_not eq('')
    end

    it 'is expected user to save if good input' do
      @u = create :user
      @u.current_balance = 300.0
      @u.save!

      User.withdraw(20.0, @u)
      expect(@u.save!).to eq(true)
    end
  end

  context 'add_error' do
    it 'is expected to fail if input is not nil' do
      @u = create :user

      expect(User.add_errors('sdfsd', @u)).to eq(false)
    end

    it 'is expected to success if input is nil' do
      @u = create :user

      expect(User.add_errors(nil, @u)).to eq(true)
    end
  end
end

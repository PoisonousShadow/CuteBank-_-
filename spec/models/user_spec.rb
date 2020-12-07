require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @_amount = -2
    @cash_machine = CashMachine.create(id: 1)
    @u = User.new(email: 'user@gmail.com', password: '123456')
    expect(@u.valid?).to eq (true)
  end  
  after(:all) do
    @u.destroy
    @cash_machine.destroy
  end
  context "Users operations" do
    it 'deposit' do
      @u = create :user 
      
      @_amount = -9999999
      while @_amount < 0 do
        expect(User.deposit(@_amount, @u)).to be_falsey
        @_amount += 9999
      end
      expect(User.deposit(0, @u)).to be_falsey
      expect(User.deposit(10, @u)).to be_truthy
    end

    it 'withdraw' do
      @_amount = -9999999
      while @_amount < 0 do
        expect(User.withdraw(@_amount, @u)).to be_falsey
        @_amount += 9999
      end
      expect(User.withdraw(0, @u)).to be_falsey
      expect(User.withdraw(10, @u)).to be_truthy
    end
  end
  
end

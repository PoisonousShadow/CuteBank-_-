RSpec.describe CashMachine, :type => :model do
  before(:all) do
    @cash_machine = CashMachine.create(id: 1)
    @cash_machine.reload #for sync with db
    @i = -2
    @u = User.new(email: 'user@gmail.com', password: '123456')
    expect(@u.valid?).to eq (true)
  end  
  after(:all) do
    @cash_machine.destroy
    @u.destroy
  end
  context "add/update cash" do
        it 'Add cash' do
          while @i < 2 do
            # it{expect('').to be_instance_of(String)}
            expect(CashMachine.add_cash(@i)).to be_truthy
            @i += 1
          end
        end

        it 'Available cash' do
          while @i < 10 do
            expect(CashMachine.cash_available?(@i, @u)).to be_truthy
            @i += 1
          end
          @i = 999999 #don`t anogh money. Expect false
          expect(CashMachine.cash_available?(@i, @u)).to be_falsey
        end

        # it "add" do
        #   expect(CashMachine.add_cash(12)).to be_truthy
        # end

        # 
        # it{expect(12).to be_a_new(Integer)}
        # it{expect(CashMachine.add_cash('')).to be_falsey}
        # it{expect(CashMachine.add_cash('1')).to be_falsey}
        # it{expect(CashMachine.add_cash('12')).to be_falsey}
      end
end

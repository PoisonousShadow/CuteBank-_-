require 'rails_helper'

RSpec.describe 'UserControllers', type: :request do
  context 'Admin is sign in' do
    context UserController, type: :controller do
      login_admin
      it { expect(get(:index)).to have_http_status(302) }
      it { expect(get(:create)).to have_http_status(302) }
    end
  end

  context 'User is sign in' do
    context UserController, type: :controller do
      before(:each) do
        CashMachine.create(id: 1)
        @request.env['devise.mapping'] = Devise.mappings[:user]
        @userast = FactoryBot.create(:user) # Using factory bot as an example
        sign_in @userast
      end

      it { expect(get(:index)).to have_http_status(200) }
      it { expect(get(:create, params: { commit: { user: @userast.attributes }, user: @userast.attributes })).to have_http_status(200) }
      it { expect(get(:create, params: { commit: '{:user => @userast.attributes}', user: @userast.attributes })).to render_template('index') }
      it { expect(post(:create, params: { commit: 'Withdraw', user: @userast.attributes })).to render_template('user/index') }
      it { expect(post(:create, params: { commit: 'Deposit', user: @userast.attributes })).to render_template('user/index') }
      it { expect(post(:create, params: { 'authenticity_token' => @userast, 'user' => { 'current_balance' => '22' }, 'commit' => 'Deposit' })).to redirect_to('/user') }

      controller do
        def operate(hash)
          super hash
        end
      end

      it 'sdfsdfs' do
        hash = {}
        hash[:commit] = 'Deposit'
        hash[:current_balance] = 234.0
        expect(controller.operate(hash)).to eq(true)
      end
    end
  end

  context 'Anonim' do
    context UserController, type: :controller do
      it { expect(get(:index)).to have_http_status(302) }
      it { expect(post(:create)).to have_http_status(302) }
    end
  end
end

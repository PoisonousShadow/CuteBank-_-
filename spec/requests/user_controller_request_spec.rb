require 'rails_helper'

RSpec.describe "UserControllers", type: :request do
    context 'Admin is sign in' do
        context UserController, type: :controller do
            login_admin
            it{expect(get :index).to have_http_status(302)}
            it{expect(get :create).to have_http_status(302)}
        end
    end

    context 'User is sign in' do
        context UserController, type: :controller do
            before(:each) do
                CashMachine.create(id: 1)
                @request.env["devise.mapping"] = Devise.mappings[:user]
                @userast = FactoryBot.create(:user) # Using factory bot as an example
                sign_in @userast
            end

            it{expect(get :index).to have_http_status(200)}
            it{expect(get :create, :params => {:commit => {:user => @userast.attributes}, :user => @userast.attributes}).to have_http_status(200)}
            it{expect(get :create, :params => {:commit => '{:user => @userast.attributes}', :user => @userast.attributes}).to render_template('index')}
            it{expect(post :create,:params => {:commit => 'Withdraw', :user => @userast.attributes}).to redirect_to('/user')}
            it{expect(post :create,:params => {:commit => 'Deposit', :user => @userast.attributes}).to redirect_to('/user')}
        end
    end

    context 'Anonim' do
        context UserController, type: :controller do
            it{expect(get :index).to have_http_status(302)}
            it{expect(post :create).to have_http_status(302)}
        end
    end
end

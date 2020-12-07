require 'rails_helper'
RSpec.describe "AdminControllers", type: :request do
    context 'Admin is sign_in' do
        describe AdminController, type: :controller do
            before(:each) do
                CashMachine.create(id: 1)
                @request.env["devise.mapping"] = Devise.mappings[:user]
                @userast = FactoryBot.create(:user, user_is_admin: true) # Using factory bot as an example
                sign_in @userast
            end

            it{expect(get :index).to have_http_status(200)}
            it{expect(get :create, :params => {:commit => {cash_amount: 0}, admin: @userast.attributes}).to have_http_status(200)}

            it 'post request' do
                post :create, :params => {:commit => {cash_amount: 0}, admin: @userast.attributes}
                expect(response).to render_template('index')

            end
        end
    end

    context 'Admin not sign in! All pages was redirect' do
        context AdminController, type: :controller do
            it{expect(get :index).to have_http_status(302)}
            it{expect(get :create).to have_http_status(302)}
            it{expect(get :index).to redirect_to('/users/sign_in')}
            it{expect(get :create).to redirect_to('/users/sign_in')}
        end
    end

    context 'User is sign_in' do
        describe AdminController, type: :controller do
            before(:each) do
                CashMachine.create(id: 1)
                @request.env["devise.mapping"] = Devise.mappings[:user]
                @userast = FactoryBot.create(:user) # Using factory bot as an example
                sign_in @userast
            end
            
            it{expect(get :index).to have_http_status(302)}
            it{expect(get :create, :params => {:commit => {cash_amount: 0}, admin: @userast.attributes}).to have_http_status(302)}

        end
    end
end

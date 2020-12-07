require 'rails_helper'

RSpec.describe "MainControllers", type: :request do
    context MainController, type: :controller do
        context 'Anonim' do
            it{expect(get :index).to have_http_status(200)}
        end
    end

    context MainController, type: :controller do
        context 'User' do
            login_user
        it{expect(get :index).to have_http_status(200)}
        end
    end

    context MainController, type: :controller do
        context 'Admin' do
            login_admin
        it{expect(get :index).to have_http_status(200)}
        end
    end
end

require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  # permite o uso dos helpers do devise
  include Devise::Test::ControllerHelpers

  # antes de cada teste será feito a autenticação de um
  # usuário fake, gerado pelo FactoryGirl
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  # no método index será testado apenas que ele retorna
  # o status de sucesso.
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # testes para a action show
  describe 'GET #show' do
    context 'campaing exists' do
      context 'User is the owner of the campaing' do
        it 'Returns success' do
          campaign = create(:campaign, user: @current_user)
          get :show, params: { id: campaign.id }
          expect(response).to have_http_status :success
        end
      end

      context 'User is not the owner of the campaign' do
        it 'Redirects to root' do
          campaign = create(:campaign)
          get :show, params: { id: campaign.id }
          expect(response).to redirect_to('/')
        end
      end
    end

    context "campaign don't exists" do
      it 'Redirects to root' do
        get :show, params: { id: 0 }
        expect(response).to redirect_to('/')
      end
    end
  end
end

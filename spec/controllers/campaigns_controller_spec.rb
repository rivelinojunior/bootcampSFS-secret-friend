require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  # permite o uso dos helpers do devise
  include Devise::Test::ControllerHelpers
  
  # antes de cada teste será feito a autenticação de um 
  # usuário fake, gerado pelo FactoryGirl
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end
  
  # no método index será testado apenas que ele retorna 
  # o status de sucesso.
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end

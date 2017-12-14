require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = FactoryGirl.create(:user)
    sign_in @current_user
  end

  describe 'POST #create' do
    before(:each) do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'User with right' do
      before(:each) do
        @campaign = create(:campaign, user: @current_user)
      end

      context 'Member is valid' do
        before(:each) do
          @member_attrs = attributes_for(:member)
          @member_attrs[:campaign_id] = @campaign.id
          post :create, params: { member: @member_attrs }
        end

        it 'return http success' do
          expect(response).to have_http_status :success
        end

        it 'Member datas is corrects' do
          expect(Member.last.name).to eql(@member_attrs[:name])
          expect(Member.last.email).to eql(@member_attrs[:email])
          expect(Member.last.campaign_id).to eql(@campaign.id)
          expect(Member.last.open).to eql(false)
        end
      end

      context 'Member is not valdid' do
        it 'return http unprocessable_entity' do
          post :create, params: { member: { name: '', email: '', campaign_id: @campaign.id } }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'Member exist' do
          @member = create(:member, campaign: @campaign)
          @member_attrs = { name: @member.name, email: @member.email, campaign_id: @member.campaign_id }
          post :create, params: { member: @member_attrs }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'User whithout right' do
      it 'return http forbidden' do
        member_attrs = attributes_for(:member)
        campaign = create(:campaign)
        member_attrs[:campaign_id] = campaign.id
        post :create, params: { member: member_attrs }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end

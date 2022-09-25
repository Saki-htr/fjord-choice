# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Issues', type: :request do
  let(:token) { ENV['FJORD_CHOICE_TOKEN'] }
  let(:invalid_token) { '無効なトークン' }
  let(:issue_params) do
    { issue: FactoryBot.attributes_for(:issue, point: ['1']) }.to_json
  end

  let(:update_params) do
    { issue: FactoryBot.attributes_for(:issue, point: ['2'], assignees: [23_456_789]) }.to_json
  end

  describe 'POSTされたイシューと同じnumberのイシューが作成されていない場合、イシューを新規作成する' do

    context '無効なトークンが渡されたとき' do
      it 'イシューを作成できないこと' do
        post api_pulls_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(invalid_token)}, params: issue_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context '有効なトークンが渡されたとき' do
      it 'イシューを作成できること' do
        expect do
          post api_issues_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(token)}, params: issue_params
        end.to change(Issue, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'POSTされたイシューと同じnumberのイシューが、既に作成されている場合、イシューを更新する' do
    let!(:created_issue) { create(:issue) }

    context '無効なトークンが渡されたとき' do
      it 'イシューを更新できないこと' do
        post api_issues_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(invalid_token)}, params: issue_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context '有効なトークンが渡されたとき' do
      it '同じnumberのイシューを更新できること' do
        post api_issues_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(token)}, params: update_params
        expect(created_issue.reload.number).to eq 1
        expect(created_issue.reload.point).to eq 2
        expect(created_issue.reload.assignees).to eq [23_456_789]
      end

      it 'Issueモデルのレコード件数が変化していないこと' do
        expect do
          post api_issues_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(token)}, params: update_params
        end.not_to change(Issue, :count)
      end
    end
  end

  private

  def authenticate_with_token(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end

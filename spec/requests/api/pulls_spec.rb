# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Pulls', type: :request do
  let(:token) { ENV['FJORD_CHOICE_TOKEN'] }
  let(:invalid_token) { '無効なトークン' }
  let(:pull_params) do
    { pull: FactoryBot.attributes_for(:pull_request) }.to_json
  end

  let(:update_params) do
    { pull: FactoryBot.attributes_for(:pull_request, title: '新しいタイトル', state: 'closed', reviewers: [23_456_789]) }.to_json
  end

  describe 'POSTされたプルリクエストと同じnumberのプルリクエストが作成されていない場合、プルリクエストを新規作成する' do

    context '無効なトークンが渡されたとき' do
      it 'プルリクエストを作成できないこと' do
        post api_pulls_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(invalid_token)}, params: pull_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context '有効なトークンが渡されたとき' do
      it 'プルリクエストを作成できること' do
        expect do
          post api_pulls_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(token)}, params: pull_params
        end.to change(PullRequest, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

  describe 'POSTされたプルリクエストと同じnumberのプルリクエストが、既に作成されている場合、プルリクエストを更新する' do
    let!(:created_pull_request) { create(:pull_request) }

    context '無効なトークンが渡されたとき' do
      it 'プルリクエストを更新できないこと' do
        expect do
          post api_pulls_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(invalid_token)}, params: pull_params
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    context '有効なトークンが渡されたとき' do
      it 'プルリクエストを更新できること' do
        post api_pulls_path, headers: { 'Content-Type' => 'application/json', 'Authorization' => authenticate_with_token(token)}, params: update_params

        expect(created_pull_request.reload.number).to eq 1
        expect(created_pull_request.reload.title).to eq '新しいタイトル'
        expect(created_pull_request.reload.state).to eq 'closed'
        expect(created_pull_request.reload.reviewers).to eq [23_456_789]
      end

      it 'PullRequestモデルのレコード件数が変化していないこと' do
        expect do
          post api_pulls_path, headers: headers, params: update_params
        end.not_to change(PullRequest, :count)
      end
    end
  end

  private

  def authenticate_with_token(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
  end
end

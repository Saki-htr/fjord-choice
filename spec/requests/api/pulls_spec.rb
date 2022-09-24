# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Pulls', type: :request do
  describe 'POST /api/pulls' do
    before do
      @token = ENV['FJORD_CHOICE_TOKEN']
    end

    let(:headers) do
      {
        "Content-Type" => "application/json",
        "Authorization" => authenticate_with_token(@token)
        }
    end

    let(:pull_params) do
      { pull: FactoryBot.attributes_for(:pull_request) }.to_json
    end

    context '無効なトークンが渡されたとき' do
      it 'ステータスコード401を返すこと' do
        headers["Authorization"] = authenticate_with_token('無効なトークン')
        post api_pulls_path, headers: headers, params: pull_params
        byebug
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context 'POSTされたPullRequestと同じnumberのPullRequestが、作成されていないとき' do
      it 'PullRequestを作成できること' do
        expect do
          post api_pulls_path, headers: headers, params: pull_params
        end.to change(PullRequest, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'POSTされたPullRequestと同じnumberのPullRequestが、既に作成されているとき' do
      let!(:created_pull_request) { FactoryBot.create(:pull_request) }

      it 'PullRequestモデルのレコード件数が変化していないこと' do
        expect do
          post api_pulls_path, headers: headers, params: pull_params
        end.to_not change(Issue, :count)
      end

      it '同じnumberのPullRequestのカラムを更新できること' do
        pull_params = { pull: FactoryBot.attributes_for(:pull_request, title: '新しいタイトル', state: 'closed', reviewers: [23_456_789]) }.to_json
        post api_pulls_path, headers: headers, params: pull_params
        expect(created_pull_request.reload.number). to eq 1
        expect(created_pull_request.reload.title). to eq '新しいタイトル'
        expect(created_pull_request.reload.state).to eq 'closed'
        expect(created_pull_request.reload.reviewers). to eq [23_456_789]
      end
    end

  private

  def authenticate_with_token(token)
    ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end
end

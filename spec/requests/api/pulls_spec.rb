# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Pulls', type: :request do
  before do
    @token = ENV['FJORD_CHOICE_TOKEN']
  end

  describe 'POST /api/pulls' do
    context 'POSTされたPullRequestと同じnumberのPullRequestが、作成されていないとき' do
      it 'PullRequestを作成できること' do
        # pull_params = FactoryBot.attributes_for(:pull_request)
        # credentials = authenticate_with_token("secret")
        pull_params = {
          pull: {

          }
        }
        # byebug
        headers = {
        "Content-Type" => "application/json",
        "Authorization" => "Token #{@token}"
        }

        expect {
          post api_pulls_path, headers: headers, params: {pull: pull_params }
        }.to change(PullRequest, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'POSTされたPullRequestと同じnumberのPullRequestが、既に作成されているとき' do
      it 'PullRequestモデルのレコード件数が変化していないこ' do

      end

      it '同じnumberのPullRequestを更新できること' do

      end
    end

    context '無効なトークンが渡されたとき' do
      it 'ステータスコード401を返すこと' do

      end
    end
  end
end

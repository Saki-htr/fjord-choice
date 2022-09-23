# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Pulls', type: :request do
  describe 'POST /api/pulls' do
    context 'POSTされたPullRequestと同じnumberのPullRequestが、作成されていないとき' do
      it 'PullRequestを作成できること' do
        params = {
          pull: {
          number: 1,
          title: 'タイトル',
          state: 'open',
          reviewers: [12_345_678],
          },
          token: ENV['FJORD_CHOICE_TOKEN']
        }
        expect {
          post api_pulls_path, params: params
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

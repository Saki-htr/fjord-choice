# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Issues', type: :request do
  describe 'POST /api/issues' do
    context 'POSTされたissueと同じnumberのissueが、作成されていないとき' do
      it 'issueを作成できること' do
        expect do
          post api_issues_path, params: {
            number: 1,
            labels: ['1'],
            assignees: [12_345_678],
            token: ENV['FJORD_CHOICE_TOKEN']
          }
        end.to change(Issue, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'POSTされたissueと同じnumberのissueが、既に作成されているとき' do
      it 'Issueモデルのレコード件数が変化していないこと' do
        create(:issue)
        expect do
          post api_issues_path, params: {
            number: 1,
            labels: ['2'],
            assignees: [23_456_789],
            token: ENV['FJORD_CHOICE_TOKEN']
          }
        end.not_to change(Issue, :count)
      end

      it '同じnumberのissueを更新できること' do
        issue = create(:issue)
        post api_issues_path, params: {
          number: 1,
          labels: ['2'],
          assignees: [23_456_789],
          token: ENV['FJORD_CHOICE_TOKEN']
        }
        expect(issue.reload.number).to eq 1
        expect(issue.reload.point).to eq 2
        expect(issue.reload.assignees).to eq [23_456_789]
      end
    end

    context '無効なトークンが渡されたとき' do
      it 'ステータスコード401を返すこと' do
        post api_issues_path, params: {
          number: 1,
          labels: ['1'],
          assignees: [12_345_678],
          token: '無効なトークン'
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

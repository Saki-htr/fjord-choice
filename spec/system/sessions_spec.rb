# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン処理' do
    context '認証が成功したとき' do
      it 'ログインできること' do
        login_as user
        expect(page).to have_content('メンバーに追加されました')
      end
    end
    context '認証が失敗したとき' do
      it 'トップページにリダイレクトすること' do
        login_as_invalid_user
        expect(page).to have_content('ログインに失敗しました')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe 'ログイン処理' do
    context '認証が成功したとき' do
      it 'ログインできること' do
        login_as(create(:user))
        expect(page).to have_content('メンバーに追加されました')
      end
    end

    context '認証が失敗したとき' do
      it 'ログインできないこと' do
      end
    end

    context 'ユーザーが認証をキャンセルしたとき' do
      it '認証せずトップページにリダイレクトすること' do

      end
    end
  end
end

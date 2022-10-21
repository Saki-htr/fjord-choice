require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe 'ログイン処理' do
    context '認証が成功したとき' do
      it 'ログインできること' do
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

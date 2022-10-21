require 'rails_helper'

RSpec.describe "Home", type: :system do

  describe 'メンバー一覧表示' do

    context '誰もログインしていないとき' do
      it '「まだ誰も登録していません」と表示されること' do

      end
    end

    context 'ログインしているとき' do
      it 'テーブルに自身のデータが表示されていること' do

      end
    end

    context 'ログインしていないとき' do
      it 'テーブルに自身のデータが表示されていないこと' do

      end
    end
  end
end

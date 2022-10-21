require 'rails_helper'
include ApplicationHelper

RSpec.describe "Home", type: :system do
  let(:user) { create(:user) }

  describe 'メンバー一覧表示' do

    context '誰もログインしていないとき' do
      it '「まだ誰も登録していません」と表示されること' do
        visit root_path
        expect(page).to have_content('まだ誰も登録していません')
      end
    end

    context 'ログインしているとき' do
      before do
        create(:issue)
        create(:pull_request)
      end
      it 'テーブルに自身のアイコンと名前が表示されていること' do
        login_as user
        # 名前のリンク確認
        expect(page).to have_link user.name, href: url_for_pulls(user)
        # 画像のリンク確認
        find("img[alt='user_icon']").click
        switch_to_window(windows.last)
        expect(page).to have_current_path url_for_pulls(user)
      end
    end

    context 'ログインしていないとき' do
      it 'テーブルに自身のデータが表示されていないこと' do

      end
    end
  end
end

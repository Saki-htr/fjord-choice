require 'rails_helper'

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
        expect(page).to have_link user.name, href: "https://github.com/Saki-htr/bootcamp_sample/pulls?q=is%3Apr+assignee%3A#{user.name}+-label%3Arelease+"

        find("img[alt='user_icon']").click
        switch_to_window(windows.last)
        expect(page).to have_current_path "https://github.com/Saki-htr/bootcamp_sample/pulls?q=is%3Apr+assignee%3A#{user.name}+-label%3Arelease+"

      end
    end

    context 'ログインしていないとき' do
      it 'テーブルに自身のデータが表示されていないこと' do

      end
    end
  end
end

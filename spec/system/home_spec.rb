# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :system do
  let!(:issue) { create(:issue) } # userにassignされたissue
  let!(:pull_request) { create(:pull_request) } # userにreview requestされたPR
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
        login_as user
      end

      it '自身のアイコンが表示され、作成したプルリクエスト一覧のGitHubリンクが付いていること' do
        find("img[alt='#{user.name}さんのアイコン画像']").click
        switch_to_window(windows.last)
        expect(page).to have_current_path url_for_pulls(user)
      end

      it '自身の名前が表示され、作成したプルリクエスト一覧のGitHubリンクが付いていること' do
        expect(page).to have_link user.name, href: url_for_pulls(user)
      end

      it '自身にアサインされたイシューの合計ポイントが表示されていること' do
        expect(page).to have_content "#{Issue.total_points(user)} / 20"
      end

      it '自身にレビュー依頼されているプルリクエストのタイトルが表示され、GitHubへのリンクが付いていること' do
        expect(page).to have_link pull_request.title, href: url_for_pull(pull_request)
      end
    end

    context 'ログインしていないとき' do
      it '自身のアイコンと名前が表示されていないこと' do
        expect(page).to have_no_selector("img[alt='user_icon']")
        expect(page).to have_no_text(user.name)
      end

      it '自身にアサインされたイシューの合計ポイントが表示されていないこと' do
        expect(page).to have_no_content "#{Issue.total_points(user)}/20"
      end

      it '自身にレビュー依頼されているプルリクエストのタイトルが表示されていないこと' do
        expect(page).to have_no_link pull_request.title, href: url_for_pull(pull_request)
      end
    end
  end
end

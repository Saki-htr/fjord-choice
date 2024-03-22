# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  let(:user2) { create(:user2) }

  describe 'ユーザ除外処理' do
    context 'アドミンでログインしているとき' do
      it 'Userモデルのレコードを削除できる' do
        Rails.application.config.admin_names = [user.name]
        OmniAuth.config.add_mock(
          user2.provider,
          uid: user2.uid,
          info: { nickname: user2.name,
                  image_url: user2.image_url }
        )

        login_as user
        click_button 'メンバーからはずす'
        expect do
          expect(accept_confirm).to eq '本当にメンバーからはずしてもいいですか?'
          expect(page).to have_content 'メンバーからはずしました'
        end.to change { User.count }.by(-1)
      end
    end

    context 'アドミンでログインしていないとき' do
      it 'Userモデルのレコードを削除できない' do
        Rails.application.config.admin_names = []

        login_as user
        expect(page).not_to have_button('メンバーからはずす')
      end
    end
  end
end

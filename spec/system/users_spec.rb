# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:admin) { create(:user) }
  let(:student) { create(:user2) }

  describe 'ユーザ除外処理' do
    context '環境変数でアドミンを指定しているとき' do
      it 'Userモデルのレコードを削除できる' do
        Rails.application.config.admin_names = [admin.name]
        OmniAuth.config.add_mock(
          student.provider,
          uid: student.uid,
          info: { nickname: student.name,
                  image_url: student.image_url }
        )

        login_as admin
        click_button 'メンバーからはずす'
        expect do
          expect(accept_confirm).to eq '本当にメンバーからはずしてもいいですか?'
          expect(page).to have_content 'メンバーからはずしました'
        end.to change { User.count }.by(-1)
      end
    end

    context '環境変数でアドミンが指定されていないとき' do
      it 'Userモデルのレコードを削除できない' do
        Rails.application.config.admin_names = []

        login_as admin
        expect(page).not_to have_button('メンバーからはずす')
      end
    end
  end
end

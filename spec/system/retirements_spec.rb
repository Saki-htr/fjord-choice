# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Retirements', type: :system do
  let(:user) { create(:user) }

  describe '退会処理' do
    context 'ログインしているとき' do
      it 'セッションとUserモデルのレコードを削除できること' do
        login_as user
        click_link 'メンバーからはずれる'
        expect do
          expect(accept_confirm).to eq '本当にメンバーからはずれてもいいですか?'
          expect(page).to have_content 'メンバーからはずれました'
        end.to change { User.count }.by(-1)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Retirements", type: :system do

  describe '退会処理' do
    context 'ログインしているとき' do
      it 'セッションとUserモデルのレコードを削除できること' do
        accept_confirm { click_on 'Delete Account' }
        expect(page).to have_content 'Successfully deleted your account!'
      end
    end
  end

end

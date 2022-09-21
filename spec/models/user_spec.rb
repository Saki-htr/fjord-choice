# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it 'ファクトリが有効であること' do # ﾊﾞﾘﾃﾞｰｼｮﾝが有効な場合
      expect(build(:user)).to be_valid
    end

    it '名前が無ければユーザーが無効であること' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'uidが無ければユーザーが無効であることが' do
      user = FactoryBot.build(:user, uid: nil)
      user.valid?
      expect(user.errors[:uid]).to include("can't be blank")
    end

    it 'providerが無ければユーザーが無効であること' do
      user = build(:user, provider: nil)
      user.valid?
      expect(user.errors[:provider]).to include("can't be blank")
    end

    it 'プロフィール画像が無ければユーザーが無効であること' do
      user = build(:user, image_url: nil)
      user.valid?
      expect(user.errors[:image_url]).to include("can't be blank")
    end

    it 'uidとproviderが重複したユーザーは作成できないこと' do
      create(:user, uid: 12_345_678)
      user = build(:user, uid: 12_345_678)
      user.valid?
      expect(user.errors[:uid]).to include('has already been taken')
    end
  end

  describe '#find_or_create_from_auth_hash!' do
    let(:user) { FactoryBot.create(:user) }

    it 'uidに対応するユーザーが既に作成されている場合、引数で設定した属性のUserオブジェクトが返ること' do
      # userはcreateされた状態
      auth_hash = { provider: user.provider, uid: user.uid, info: { nickname: user.name, image: user.image_url } }
      expect(User.find_or_create_from_auth_hash!(auth_hash)).to eq user
    end

    it 'uidに対応するユーザーがレコードに無い場合、新しいユーザーを作成すること' do
      # userはnew(まだDB保存されてない)状態
      new_user = build(:user)
      new_user_auth_hash = { provider: new_user.provider, uid: new_user.uid, info: { nickname: new_user.name, image: new_user.image_url } }
      expect { User.find_or_create_from_auth_hash!(new_user_auth_hash) }.to change(User, :count).from(0).to(1)
    end

    it '無効なuidが渡されると、nilが返ること' do
      auth_hash = { provider: user.provider, uid: nil, info: { nickname: user.name, image: user.image_url } }
      expect(User.find_or_create_from_auth_hash!(auth_hash)).to be nil
      expect { User.find_or_create_from_auth_hash!(auth_hash) }.to raise_error ActiveRecord::RecordInvalid
      expect(nil). to be nil
    end
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :provider
    validates :uid
    validates :image_url
  end
  validates :uid, uniqueness: { scope: :provider }

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]

    # 引数に渡したproviderとuidがUserのレコードに有れば、そのオブジェクトを返す
    # 無ければ、引数に渡したproviderとuidに加えて、nameとavatar_urlを設定してレコード作成&そのオブジェクトを返す

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image_url
    end
  end
end

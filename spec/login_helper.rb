# frozen_string_literal: true

module LoginHelper
  def login_as(user)
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { nickname: user.name,
              image_url: user.image_url }
    )

    visit root_path
    click_button 'メンバーに自分を追加する'
    @current_user = user
  end

  def current_user
    @current_user
  end
end

# frozen_string_literal: true

module LoginHelper
  def login_as(user)
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: { nickname: user.name,
              image_url: user.image_url }
    )
    ensure_browser_size if Capybara.current_driver == :selenium_chrome_headless
    visit root_path
    click_button 'メンバーに自分を追加する'
    @current_user = user
  end

  def login_as_invalid_user
    OmniAuth.config.mock_auth[:github] = :invalid_credentails
    ensure_browser_size if Capybara.current_driver == :selenium_chrome_headless
    visit root_path
    click_button 'メンバーに自分を追加する'
  end

  def current_user
    @current_user
  end

  def ensure_browser_size(width = 1400, height = 1400)
    Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
  end
end

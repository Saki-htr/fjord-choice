require 'webdrivers/chromedriver'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome
  end
end

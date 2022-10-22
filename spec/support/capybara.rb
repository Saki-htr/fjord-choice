# frozen_string_literal: true

require 'webdrivers/chromedriver'
require_relative '../login_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end

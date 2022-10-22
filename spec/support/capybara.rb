# frozen_string_literal: true

# require 'selenium-webdriver'
require_relative '../login_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome
  end
end

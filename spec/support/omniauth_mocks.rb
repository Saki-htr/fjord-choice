# frozen_string_literal: true

module OmniauthMocks
  def github_invalid_mock
    OmniAuth.config.mock_auth[:github] = :invalid_credentails
  end
end

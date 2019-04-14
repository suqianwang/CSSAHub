require 'simplecov'
SimpleCov.start
require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rails'
require 'factory_bot_rails'
require Rails.root.join("spec/support/geocoding")


OmniAuth.config.test_mode = true

OmniAuth.config.add_mock(:google_oauth2, {
  uid: "12345678910",
  info: {
    email: "bob@tamu.edu",
    name: "bob"
  },
  credentials: {
    token: "abcdefg12345",
    refresh_token: "12345abcdefg"
  }
})

# request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]

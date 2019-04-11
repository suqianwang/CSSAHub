require 'simplecov'
SimpleCov.start
require 'capybara'
require 'capybara/cucumber'
require 'cucumber/rails'
require 'factory_bot_rails'
require Rails.root.join("spec/support/geocoding")

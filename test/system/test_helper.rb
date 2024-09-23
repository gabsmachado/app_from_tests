# frozen_string_literal: true

require 'test_helper'
require 'capybara/minitest'
require 'selenium-webdriver'

class SystemTestBase < ActionDispatch::SystemTestCase
  HEADLESS = ENV.fetch('HEADLESS', true) != 'false'

  if ENV['USE_SELENIUM_CONTAINER']
    url = HEADLESS ? "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub" : "http://#{ENV['HOST_DOCKER_DOMAIN']}:9515"
    options = { browser: :remote, url: url, desired_capabilities: :chrome }

    driven_by :selenium, using: :chrome, options: options
  else
    driven_by :selenium, using: :chrome
  end

  include Capybara::DSL
  include Capybara::Minitest::Assertions

  self.use_transactional_tests = true

  setup do
    Time.zone = Rails.application.config.time_zone

    if ENV['USE_SELENIUM_CONTAINER']
      Capybara.server_host = HEADLESS ? `/sbin/ip route|awk '/scope/ { print $9 }'`.strip : '0.0.0.0'
      Capybara.server_port = ENV['CAPYBARA_SERVER_PORT']

      session_server = Capybara.current_session.server
      Capybara.app_host = "http://#{session_server.host}:#{session_server.port}"
    end

    Capybara.default_max_wait_time = 10
    EVENT_STORE.restore_subscriptions
  end

  teardown do
    Capybara.reset_sessions!
  end
end

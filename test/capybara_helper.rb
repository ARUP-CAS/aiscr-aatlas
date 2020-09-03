# -*- coding: utf-8 -*-
require 'database_cleaner'


class CapybaraTest < ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.clean
    Capybara.default_driver = :my_poltergeist
    DatabaseCleaner.strategy = :truncation
    Capybara.app = Bu2r::Application
  end

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
    # https://medium.com/@thatandyrose/testing-ember-js-with-capybara-and-rspec-f793d7ddb49
    wait_for_ajax rescue nil
    DatabaseCleaner.clean
  end

  private

  def wait_for_ajax
    counter = 0
    while true
      # active = page.execute_script(“return $.active”).to_i
      # puts “AJAX $.active result: “ + active.to_s
      active = page.evaluate_script('$.active').to_i

      break if active < 1
      counter += 1
      sleep(0.1)
      raise "AJAX request took longer than 5 seconds OR there was a JS error. Check your console." if counter >= 50
    end
  end

  def screenshot
    save_screenshot('tmp/capybara/now.png')
  end
  
end

require 'capybara/cucumber'
require 'json'
require 'pry-byebug' if ENV['DEBUG']

# set chrome as default driver
Capybara.register_driver :selenium do |app|
  	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium

# set base url
Capybara.app_host = 'http://localhost:8080'

Capybara.default_max_wait_time = 5

#Capybara.javascript_driver = :chrome

# set xpath as default selector
Capybara.default_selector = :xpath

# set browser window size
def set_selenium_window_size(width, height)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(width, height)
end

set_selenium_window_size(1300, 768)

file = File.read('../locators/portal.json')
$locators_hash = JSON.parse(file)

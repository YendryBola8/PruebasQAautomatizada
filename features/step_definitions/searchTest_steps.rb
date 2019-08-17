require 'rubygems'
require 'selenium-webdriver'
require "test/unit"
require 'test/unit/assertions'
include Test::Unit::Assertions

prefs = {
    prompt_for_download: false,
    default_directory: "../resource/chromedriver"
}

options = Selenium::WebDriver::Chrome::Options.new
options.add_preference(:download, prefs)
options.add_argument('--ignore-certificate-errors')
options.add_argument('--disable-popup-blocking')
options.add_argument('--disable-translate')
options.add_argument('--disable-extensions')
options.add_argument('--start-maximized')
driver = ""

Given(/^Open Chrome$/) do
  driver = Selenium::WebDriver.for :chrome, options: options
  sleep 3
end

When(/^We navigate to the homepage google$/) do
  driver.navigate.to "http://www.google.com.co/"
  sleep 2
end

When(/^We write the word "([^"]*)"$/) do |test|
  driver.find_element(:name, "q").send_keys test
  sleep 2
  driver.action.send_keys(:enter).perform
  driver.action.send_keys(:return).perform
end

Then(/^Validate that the correct word is loaded "([^"]*)"$/) do |text|
  sleep 2
  element = driver.find_element :id => "fprsl"
  sleep 2
  assert_equal text, element.text
end

And(/^Click on the correct word pruebas$/) do
  sleep 2
  element = driver.find_element(:id, 'fprsl').click
end

cheeses = ""

And(/^Get the list of results$/) do
  sleep 2
  cheeses = driver.find_elements(:class, "LC20lb")
  sleep 2
end

Then(/^validate that the number of results is greater than "([^"]*)"$/) do |numberresults|
  sleep 2
  puts cheeses.length
  assert cheeses.length >Integer(numberresults)
  cheeses.each do |elemento|
    puts elemento.text
  end
  sleep 2
  driver.quit
end
Given(/^I sign in to Liferay Portal as "([^"]*)"$/) do |email|
	visit Capybara.app_host
	click 'link', 'Sign In'
	input 'text_field', 'test@liferay.com', 'Email Address'
	input 'text_field', 'test', 'Password'
	click 'button', 'Sign In'
end

Given(/^I visit "([^"]*)"$/) do |url|
	visit url
end

When(/^I click the "([^"]*)" "([^"]*)"$/) do |label, object|
	click object, label
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |label, text|
	input 'text_field', text, label
end

Then(/^I should be signed in$/) do
	sleep(2)
end
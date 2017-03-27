Given(/^I sign in to Liferay Portal as "([^"]*)"$/) do |email|
	visit Capybara.app_host
	click 'link', 'Sign In'
	input 'text_field', ' Email Address ', 'test@liferay.com'
	input 'text_field', ' Password ', 'test'
	click 'button', 'Sign In'
end

Given(/^I visit "([^"]*)"$/) do |url|
	visit url
end

When(/^I click the "([^"]*)" "([^"]*)"$/) do |label, object|
	click object, label
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |label, text|
	input 'text_field', label, text
end

Then(/^I should be signed in$/) do
  pending # Write code here that turns the phrase above into concrete actions
end


# Given(/^I go to "([^"]*)" > "([^"]*)" in the Product Menu$/) do |menu_item, subitem|
# 	Topbar.open_left_side_bar
# 	LeftSideBar.expand menu_item
# 	LeftSideBar.click_link subitem
# end
#
# Given(/^I configure workflow via folder info for "([^"]*)"$/) do |workflow|
# 	WebContent.click_info_button
# 	WebContent.click_info_ellipsis
# 	WebContent.select_from_info_ellipsis_menu "Edit"
# 	WebContent.select_workflow workflow
# 	WebContent.click_button "Save"
# 	expect(WebContent).to have_success_message "Your request completed successfully."
# end
#
# Given(/^I add a new page named "([^"]*)"$/) do |name|
# 	Topbar.open_left_side_bar
# 	LeftSideBar.expand "Navigation"
# 	LeftSideBar.select_from_public_pages_menu "Add Public Page"
# 	AddNewPage.fill_in "Name", with: name
# 	AddNewPage.click_button "Add Page"
# 	expect(AddNewPage).to have_success_message "The page was created successfully."
# end
#
# When(/^I add a "([^"]*)" portlet to the page$/) do |portlet|
# 	Topbar.open_right_side_bar
# 	RightSideBar.add_portlet portlet
# end
#
# When(/^I add the following Web Content with workflow via Web Content Display$/) do |table|
# 	table.raw.each do |content, title|
# 		WebContentDisplayPortlet.add_basic_web_content content, title
# 	end
# end
#
# Then(/^I should see the following Web Content is "([^"]*)"$/) do |status, table|
# 	expect(WebContentDisplayPortlet).to have_warning_message "WC WebContent Title is not approved."
# 	WebContentDisplayPortlet.click_warning_message
#
# 	table.raw.each do |content, title|
# 		expect(WebContentDetail.el_workflow_status).to have_text status
# 		expect(WebContentDetail).to have_content content
# 		expect(WebContentDetail).to have_title title
# 	end
# end
#
# When(/^I go to "([^"]*)" > "([^"]*)" in the User Menu$/) do |menu_item, subitem|
# 	Topbar.open_left_side_bar
# 	LeftSideBar.expand "Test"
# 	LeftSideBar.expand menu_item
# 	LeftSideBar.click_link subitem
# end
#
# When(/^I assign to myself an? "([^"]*)" task for the following Web Content$/) do |task, table|
# 	MyWorkflowTasks.click_link "Assigned to My Roles"
#
# 	table.raw.each do |content, title|
# 		MyWorkflowTasks.click_link title
# 		expect(page).to have_text "Review: #{title}", wait: 10
# 		MyWorkflowTasksTask.el_vertical_ellipsis.click
# 		MyWorkflowTasksTask.click_link "Assign to Me"
# 		MyWorkflowTasksTask.add_comment
# 	end
# end
#
# Given(/^I go to the page "([^"]*)"$/) do |page_name|
# 	Topbar.open_left_side_bar
# 	LeftSideBar.expand "Liferay DXP"
# 	LeftSideBar.expand "Navigation"
#
# 	retry_method(3, RSpec::Expectations::ExpectationNotMetError) do
# 		LeftSideBar.click_link page_name
# 		expect(SiteNavigationPortlet).to have_active_page page_name
# 	end
# end
#
# When(/^I approve the following Web Content$/) do |table|
# 	MyWorkflowTasks.click_link "Assigned to Me"
#
# 	table.raw.each do |content, title|
# 		MyWorkflowTasks.click_link title
# 		expect(page).to have_text "Review: #{title}"
# 		MyWorkflowTasksTask.el_vertical_ellipsis.click
# 		MyWorkflowTasksTask.click_link "Approve"
# 		MyWorkflowTasksTask.add_comment
# 	end
# end
#
# When(/^I should see the following Web Content displayed in the portlet$/) do |table|
# 	table.raw.each do |content, title|
# 		expect(WebContentDisplayPortlet.el_webcontent_content).to have_text content
# 		expect(WebContentDisplayPortlet.el_webcontent_title).to have_text title
# 	end
# end
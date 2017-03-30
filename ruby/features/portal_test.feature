Feature:  Liferay Portal

Scenario:  Log in to Liferay Portal
	Given I visit "localhost:8080"
	When I click the "Sign In" "link"
	And I fill in "Email Address" with "test@liferay.com"
	And I fill in "Password" with "test"
	And I click the "Sign In" "button"
	Then I should be signed in

Scenario:  Navigate to Web Content
	Given I sign in to Liferay Portal as "test@liferay.com"
	When I open the Product Side Bar
	And I expand the "Liferay" panel
	And I click the "Content" "link"
	And I click the "Web Content" "link"
	Then I pause for "3" seconds

Scenario:  Add a new page
	Given I sign in to Liferay Portal as "test@liferay.com"
	When I open the Product Side Bar
	And I expand the "Liferay" panel
	And I expand the "Navigation" submenu
	And I open the "Public Pages" ellipsis menu
	And I select "Add Public Page" from the dropdown menu
	And I fill in "Name" with "Test Page"
	And I click the "Add Page" "button"
	Then I should see the success message

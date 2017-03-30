Feature:  Liferay Portal

Background:
#	Given I sign in to Liferay Portal as "test@liferay.com"

Scenario:  Log in to Liferay Portal
	Given I visit "localhost:8080"
	When I click the "Sign In" "link"
	And I fill in "Email Address" with "test@liferay.com"
	And I fill in "Password" with "test"
	And I click the "Sign In" "button"
	Then I should be signed in
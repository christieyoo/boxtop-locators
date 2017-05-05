# Boxtop Locators

----------

## Synopsis


Boxtop locators is an R&D project where we serialize locators and waitfors on objects in json. In this repo we have a working example of two testing frameworks both using cucumber and the same json locator files. 

By serializing the locators, we are able to generalize locators to be used in just about any type of browser automation. If your QA department were to move to a new testing framework or if any other departments want to use a different framework, the locators are still usable.

----------

## Usage

The json structure for locators should be simple for users to be able to look through the index. In this example we have a button object in base.json. In this index of objects we're able to share a generic locator for the button object with other frameworks. 

As a child, we have a *wait_for_present* node that carries a description and elements to wait for or not wait for. This can also be used with *wait_for_not_present* to wait for something to not be there. In an effort to keep things DRY, in the *wait_for_present* / *wait_for_not_present* nodes, we call the name of the element that we're storing int he same locator file.

locators/product_menu.json:

    {
	"product_menu_toggle": {
		"xpath": "//a[@data-qa-id='productMenu']",
		"wait_for_present": {
			"description": "Wait until this element is present when opening menu panel",
			"xpath": "//a/span[text()='Control Panel']"
		},
		"wait_for_not_present": {
			"description": "Wait until this element is not present when closing menu panel",
			"xpath": "//a/span[text()='Control Panel']"
		}
	}

Now that we have this json file being passed around, we need a way to interpret it. 
In the env file for cucumber we have some logic that loads the json files for use. In the logic below, we merge all the files into a hash

ruby/features/support/env.rb

    $locators_hash = {}
	locator_files = Dir.glob('../locators/*.json')

	locator_files.each do |filename|
	  file = File.read(filename)
	  $locators_hash.merge!(JSON.parse(file))
	end

ruby/features/support/base_actions.rb:

	def self.element(type, opts={})
		xpath = $locators_hash[type]['xpath']
		css = $locators_hash[type]['css']
		label = opts[:label]

		if xpath
			xpath = xpath.gsub(/{access_name}/, label) if label
			page.find(:xpath, xpath, wait: 15)
		else
			page.find(:css, css, wait: 15)
		end
	end

This is responsible for interpreting the json file so we can use it.

Next here is something we have for a basic click. We're designing our click method to accept a label so we can generalize our elements on the page. So if we have a button that says "Save" we just give it the word "Save" and the element "button" to work.

    def click(element, label='')
		BaseActions.element(element, label: label).click
	end

If you're still with me, the next thing up is an example of the click being used in the product_menu class for the method *open*.

ruby/features/support/pages/product_menu.rb: (*needs to be updated later with the nested waits*)

    def self.open
		if page.has_no_xpath? xpath("product_menu_control_panel"), wait: 1
			click 'product_menu_toggle'
			page.should have_xpath($locators_hash['product_menu_toggle']['wait_for_present']['xpath'])
		end
	end

We're almost done. The very last part is using it in a step definition for our feature files. 

ruby/features/step_definitions/test_steps.rb:

    When(/^I open the Product Side Bar$/) do
		ProductMenu.open
	end

That's basically it! Just repeat the process for any new elements that you need to create. Remember to keep things DRY.

boxtop-locators/ruby/features/portal_test.feature

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

----------

## Installation

### Java

How to install the java

### Ruby

How to install the ruby stuff

----------

## Tests

### Java

How to run the java tests

### Ruby

How to run the Ruby tests

----------

## Contributors

 - Cheryl Tang || [cheryl.tang@liferay.com](cheryl.tang@liferay.com)
 - Christie Yoo || [christie.yoo@liferay.com](christie.yoo@liferay.com)
 - Kevin Yen || [kevin.yen@liferay.com](kevin.yen@liferay.com)
 - Kristoffer Onias || [kristoffer.onias@liferay.com](kristoffer.onias@liferay.com)

module BaseActions
	extend Capybara::DSL

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

	def click(type, label='')
		BaseActions::element(type, label: label).click
	end

	def css(type)
		$locators_hash[type]['css']
	end

	def has_success_message?
		BaseActions::element("alert_success").visible?
	end

	def input(type, text, label='')
		BaseActions::element(type, label: label).set text
	end

	def select_item(type, item)
		BaseActions::element(type, label: item).click
	end

	def xpath(type, access_name='')
		$locators_hash[type]['xpath'].gsub(/{access_name}/, access_name)
	end
end

World(BaseActions)
module BaseActions
	extend Capybara::DSL

	def self.element(type, opts={})
		puts opts.to_s
		xpath = $locators_hash[type]['xpath']
		css = $locators_hash[type]['css']
		label = opts[:label]

		if xpath.empty?
			page.find(:css, css)
		else
			xpath = xpath.gsub(/{access_name}/, label) unless label.empty?
			page.find(:xpath, xpath)
		end
	end

	def click(type, label='')
		BaseActions::element(type, label: label).click
	end

	def input(type, text, label='')
		BaseActions::element(type, label: label).set text
	end
end

World(BaseActions)
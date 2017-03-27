module BaseActions
	def click(type, label)
		path = $locators_hash[type]
		path = path.gsub(/{access_name}/, label)
		page.find(path).click
	end

	def input(type, label, text)
		path = $locators_hash[type]
		path = path.gsub(/{access_name}/, label)
		page.find(path).set text
	end
end

World(BaseActions)
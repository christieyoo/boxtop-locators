class NavigationMenu < BasePage
	def self.select_page(page)
		click 'page_link', page
	end
end
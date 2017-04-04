class ProductMenu < BasePage
	def self.click_ellipsis(menu_item)
		case menu_item
		when "Public Pages"
			click 'product_menu_public_pages_ellipsis'
		else
			# TODO
		end
	end

	def self.expand_panel(name)
		path = xpath("product_menu_collapsed_panel", name)

		if page.has_xpath? path, wait: 1
			click 'product_menu_panel_title', name
		end
	end

	def self.expand_submenu(name)
		path = xpath("product_menu_collapsed_submenu", name)

		if page.has_xpath? path, wait: 1
			click 'link', name
		end
	end

	def self.open
		until page.has_xpath? xpath("product_menu_control_panel"), wait: 1
			click 'product_menu_toggle'
		end
	end
end

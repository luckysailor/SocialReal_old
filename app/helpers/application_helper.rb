module ApplicationHelper
	def page_title title
		"#{page_name} - Social Real"
	end

	def page_name
		params_humanize
	end

	def current_year
		Time.current.strftime("%Y")
	end
end

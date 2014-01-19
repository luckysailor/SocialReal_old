module ApplicationHelper
	def page_title title
		title.present? ? "#{title} - Social Real" : "Social Real"
	end
end

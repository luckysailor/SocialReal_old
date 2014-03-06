module ApplicationHelper
	def page_title options={}
		second_title = options[:second_title]
		if second_title.present?
			"#{page_title_humanize} - #{second_title}"
		else
			page_title_humanize
		end
	end

	# We have only 2 type of format that are: :normal and :thumb
	def profile_photo(user, attributes={})
		style = attributes[:style] ? attributes[:style] : 'img-rounded'
		profile = user.profile
		if profile.picture.present?
			format = attributes[:format] ? attributes[:format] : :normal
			image_tag(profile.picture_url(format.to_sym), alt: "#{profile.name}", class: style)
		else
			image_tag('no_photo.png', size: "150x150", alt: "#{profile.name}", class: style)
		end
	end

	def first_name(name)
		name = name.split(" ")
		name[0]
	end

	def current_year
		Time.current.strftime("%Y")
	end
end

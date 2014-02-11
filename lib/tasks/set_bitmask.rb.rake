namespace :user do
	desc "Change roles mask of a User i.e, rake user:set_bitmask email=example@test.com bitmask=1"

	task :set_bitmask => :environment do |t, args|
		unless ENV['email'].present? and ENV['bitmask'].present?
			puts "Please, type the email and bitmask correctly."
			next
		end
		unless user = User.find_by_email(ENV['email'])
			puts "Email not found!"
			next
		end
		user.roles_mask = ENV['bitmask']
		if user.save!
			puts 'User has been successful update!.'
		else
			puts 'Error. Bitmask not can be saved!'
		end
	end
end

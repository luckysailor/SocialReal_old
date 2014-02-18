class Users::RegistrationsController < Devise::RegistrationsController

	protected

	# Overwriting the behavior when after update a resource
	def after_update_path_for(resource)
		dashboard_path
	end
end
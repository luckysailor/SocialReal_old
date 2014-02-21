class Users::RegistrationsController < Devise::RegistrationsController
	layout 'dashboard', only: [:edit, :update]

	protected

	# Overwriting the behavior when after update a resource
	def after_update_path_for(resource)
		dashboard_path
	end
end
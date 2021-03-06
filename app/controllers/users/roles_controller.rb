class Users::RolesController < ApplicationController
	include Authenticate
	before_action :current_can_update?, only: [:update]
	layout 'dashboard'

	def index
	end

	def show
		 @user = User.find_by_email(roles_params[:email]) || not_found
	end

	def update
		user = @@user_to_be_update
		user.roles_mask=@@roles_user_to_be_update
	 	if user.save!
			redirect_to dashboard_path, notice: ["Update!"]
		else
			redirect_to dashboard_path, alert: ["Ops! Sorry. Our programmers has been reported"]
		end
	end

	protected
	
	def roles_params
		params.require(:role).permit(:bitmask, :email)
	end

	# Verify if the User which are requesting the UPDATE have an bitmask/level bigger to do that.
	# Example: if Admin (have bitmask 1) and want change Master (have bitmask 2), Admin can do this, beucause
	# he have the bitmask 1 bigger than bitmask 2. How you see, the order are inverted 1 is bigger than 2.
	# and so then check also if the request is to same user, so its request is denied.
	def current_can_update?
		_find_user_to_be_update
		_check_bitmask_params(roles_params[:bitmask])

		if current_user == @@user_to_be_update
			redirect_to dashboard_path, alert: ["You not can change your role."]
		elsif !@@roles_user_to_be_update or current_user.roles_mask >= @@roles_user_to_be_update
			redirect_to dashboard_path, alert: ["You not have permissions to do this."]
		end
	end

	def _find_user_to_be_update
		@@user_to_be_update = User.find_by_id(params[:user_id]) || not_found
		@user_to_be_update = @@user_to_be_update
	end

	def _check_bitmask_params(bitmask)
		bitmask = bitmask.to_i
		@@roles_user_to_be_update = bitmask if @@user_to_be_update.check_bitmask(bitmask)
	end

	def not_found
		redirect_to dashboard_path, alert: ["Ops! Not found!"]
	end
end
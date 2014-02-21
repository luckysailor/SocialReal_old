class DashboardController < ApplicationController
	before_action :authenticate_user!
	authorize_resource :class => false
	layout 'dashboard'

	def index
	end
end
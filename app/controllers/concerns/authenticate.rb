module Authenticate
	extend ActiveSupport::Concern
  
  included do
  	begin
  		@@resource_name = controller_name.classify.constantize
  	rescue NameError
  		@@resource_name = controller_name.to_sym
  	end
  	
  	before_action :authenticate_user!
  	authorize_resource :class => @@resource_name
    before_action :configure_profile, unless: :devise_controller?
  end

  protected

  def configure_profile
    unless current_user_have_profile?
      unless controller_path == 'profiles' and (action_name == 'new' or action_name == 'create')
        redirect_to new_profile_path
      end
    end
  end
end
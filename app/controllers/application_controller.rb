class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :params_humanize
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    dashboard_path 
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  protected

  def params_humanize
    controller = params["controller"].split('/')[0].capitalize
    action = " - " + params["action"].capitalize if params["action"] != "index"
    "#{controller}#{action}"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :terms_of_use
  end
end

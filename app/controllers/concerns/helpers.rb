module Helpers
	extend ActiveSupport::Concern
  
  included do
    helper_method :page_title_humanize, :current_user_have_profile?, :current_user_profile
  end

  protected

  def current_user_have_profile?
    User.user_have_profile?(current_user)
  end

  def page_title_humanize
    controller = _controller_name_humanize(controller_path)
    action = " - " + action_name.capitalize if params["action"] != "index"
    "#{controller}#{action}"
  end

  def current_user_profile
    Profile.find_by_user_id(current_user)
  end

  def _controller_name_humanize(controller)
    controller = controller.split('/')
    if controller.count > 1
      controller = controller.map {|a| a.singularize}
      controller = controller * ' '
    else
      controller = controller[0].singularize
    end
    controller = controller.capitalize
  end
end
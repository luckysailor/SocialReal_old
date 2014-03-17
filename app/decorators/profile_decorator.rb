class ProfileDecorator < Draper::Decorator
  delegate_all

 def edit_profile
 	if context[:current_user_can_edit?]
    helpers.content_tag :p, class: 'box-title' do
    	helpers.link_to 'Edit', helpers.edit_profile_path(object)
    end
  end
 end
end

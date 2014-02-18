require 'active_support/test_case'

class ActiveSupport::TestCase
  def sign_in_as_user(user=nil, options={})
    visit new_user_session_path
    user ||= create_user_and_skip_confirmation
    fill_in 'user_email', :with => options[:email] || user.email
    fill_in 'user_password', :with => options[:password] || '12345678'
    check 'remember me' if options[:user_remember_me] == true
    click_on 'Sign in'
  end

  def sign_out()
    visit dashboard_path
    within("div#bs-example-navbar-collapse-1") do
      within('ul.nav.navbar-nav.navbar-right') do
        within("li#account.dropdown") do
          find('a.dropdown-toggle').click
          within "ul.dropdown-menu" do
            within("li#logout") do
              find("a#lougout").click
            end
          end
        end
      end
    end
  end
end
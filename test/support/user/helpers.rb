require 'active_support/test_case' 

class ActiveSupport::TestCase
  def generate_unique_email
    @@email_count ||= 0
    @@email_count += 1
    "test#{@@email_count}@example.com"
  end

  def valid_attributes(attributes={})
      {:email => generate_unique_email, :password => '12345678',
      :password_confirmation => '12345678' }.update(attributes)
  end 

  def create_user(attributes={})
  	User.new(valid_attributes(attributes))
  end

  def create_user_and_skip_confirmation
  	user = create_user
  	user.skip_confirmation!
 	user.save!
 	user
  end

  def create_user_with_bitmask(bitmask)
  	user = create_user_and_skip_confirmation
  	change_bitmask(user, 0)
  end

  def change_bitmask(user, bitmask)
  	user.roles_mask = bitmask
  	user.save!
  	user
  end
end
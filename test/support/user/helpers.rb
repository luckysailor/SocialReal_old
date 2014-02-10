require 'active_support/test_case' 

class ActiveSupport::TestCase
  def generate_unique_email
    @@email_count ||= !User.last.present? ? 0 : User.last.id
    @@email_count += 1
    "test#{@@email_count}@example.com"
  end

  def valid_attributes(attributes={})
    {:email => generate_unique_email, :password => '12345678', created_at: Time.now.utc}
  end 

  def create_user(attributes={})
    User.new(valid_attributes(attributes))
  end

  def create_user_and_skip_confirmation(options={})
    user = create_user
    user.lock_access! if options[:locked] == true
    user.save!
    User.last.confirm!
    User.last
  end

  def create_user_with_bitmask(bitmask)
    user = create_user_and_skip_confirmation
  	user.roles_mask=bitmask if bitmask.present?
    user.save!
    user
  end
end
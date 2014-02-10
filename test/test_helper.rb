ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# https://github.com/jnicklas/capybara#transactions-and-database-setup
# Use the same transaction for all threads, is temporarily, let's use the gem:
# https://github.com/bmabey/database_cleaner
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil
 
  def self.connection
    @@shared_connection || retrieve_connection
  end
end
# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite
  Devise.stretches = 1
  Rails.logger.level = 4

  fixtures :all

  # Load all supports
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
end

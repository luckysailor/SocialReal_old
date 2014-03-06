class User < ActiveRecord::Base
  has_one :profile

  require 'role_model'
  include RoleModel
  include Bitmask

  attr_accessor :terms_of_use

  validates_acceptance_of :terms_of_use,
   message: 'Social Real, you need accept.'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,\
         :confirmable, :lockable, :timeoutable

  # Bitmasks
  # :admin = 1
  # :master = 2
  # :guardian = 4
  # :partner = 8
  # :member = 16
  # :guest = 32
  #
  # Notice: 'New user' default is :guest or bitmask 32.
  roles_attribute :roles_mask
  # Please, not change the order!
  roles :admin, :master, :guardian, :partner, :member, :guest

  def self.user_have_profile?(user)
    user.profile.present?
  end
end

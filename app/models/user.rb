class User < ActiveRecord::Base
  require 'role_model'
  include RoleModel

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
  # admin+master+guardian+partner+member+guest = 63
  #
  # Notice: 'New user' default is :guest or bitmask 32.
  roles_attribute :roles_mask
  # Please, not change the order!
  roles :admin, :master, :guardian, :partner, :member, :guest
end

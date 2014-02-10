class Ability
  include CanCan::Ability

  def initialize(user)
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # For check the bitmask run: user.roles_mask
    # For check if satisfies any roles run: user.has_any_role? :author, :guest
    # For check a role run: user.has_hole? :admin
    # For check if satisfies all roles run: user.has_all_roles? :author, :guest
      
    # If you don't have a resource then, use the example of Dashboard
    # pass the controller name ('example, :dashboard') instead of the resource
    # and in the Controller use "authorize_resource :class => false"

      user ||= User.new # guest user (not logged in)

      case
      when user.roles_mask == 1 #admin
        can :manage, :all
      when user.roles_mask == 2 #master
       can :read, :dashboard
       can :manage, :roles
      when user.roles_mask == 4 #guardian
       can :read, :dashboard
      when user.roles_mask == 8 #partner
       can :read, :dashboard
      when user.roles_mask == 16 #member
       can :read, :dashboard
      when user.roles_mask == 32 #guest
       can :read, :dashboard
      end
  end
end

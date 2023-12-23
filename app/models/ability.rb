# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :create, Comment if user.persisted? # Allow creating comments for logged-in users
      # Define abilities for different roles
      if user.admin?
        can :manage, :all # Admins can manage all resources
      else
        can :read, :all
        can :create, Post
        can :destroy, Post, author_id: user.id
        can :destroy, Comment, author_id: user.id
  
      end
    end
end

# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 
    can :create, Comment if user.persisted? 
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, Post
        can :destroy, Post, author_id: user.id
        can :destroy, Comment, author_id: user.id
  
      end
    end
end
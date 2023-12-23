# frozen_string_literal: true
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # Guest user (not logged in)
    can :read, Post
    if user.persisted?
      can :create, Comment
      can :read, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
      if user.admin?
        can :manage, :all
      else
        can [:update, :api_index, :api_comments, :api_add_comment], Post, author_id: user.id
      end
    end
  end
end
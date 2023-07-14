# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  can read, User
  
  if user.present?
    can :manage, Category, author_id=user.id 
    can :manage, Entity, category: {author_id=user.id}
  end
   
  end
end

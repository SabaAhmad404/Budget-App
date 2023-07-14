class Ability
  include CanCan::Ability

  def initialize(user)
    can read, User

    return unless user.present?

    can :manage, Category, user.id
    can :manage, Entity, category: { author_id: user.id }
  end
end

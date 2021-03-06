class Ability
  include CanCan::Ability

  def initialize(user)
    # para poder manejar las habilidades en caso de un usuario no logueado
    user ||= User.new

    if user.moderator?
        can :manage, :all
    elsif user.guest?
        can :read, :all
        can :create, [Post, Comment]
        can [:update, :destroy], [Post, Comment], user_id: user.id
    else
        can :read, :all
    end

  end
end

class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end
end

class AnnouncementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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

  def destroy?
    record.user == user # Only creator of announcement can delete it
  end
end

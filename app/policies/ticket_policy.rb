class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # need to filter for teacher or parent owner
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

  def update?
    true
  end
end

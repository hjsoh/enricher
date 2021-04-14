class OfficeHourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      else scope.where(user:user)
      end
    end
  end

  def new?
    user.role == "teacher"
  end

  def create?
    new?
  end

  def edit?
    user == record.user
  end

  def update?
    edit?
  end
end

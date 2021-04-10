class OfficeHourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      else scope.where(user:user)
      end
    end
  end
end

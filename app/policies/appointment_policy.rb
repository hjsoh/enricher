class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      elsif user.role == 'teacher'
        scope.where(user: user)
      else
        user.student_appointments
      end
    end
  end

  def new?
    user.role == "parent"
  end

  def create?
    new?
  end
end

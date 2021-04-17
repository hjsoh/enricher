class AppointmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      else
        # show all available office hours or own appointments
        scope.where(user: user)
      end
    end
  end

  def new?
    user.role == "parent"
  end

  def create?
    new?
  end

  def appointment_new?
    user.role == "parent"
  end

  def appointment_create?
    appointment_new?
  end
end

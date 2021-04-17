class OfficeHourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      # if teacher, show only own office hours
      elsif user.role == 'teacher'
        # scope.where(user:user)
        user.office_hours
      # if parent, show office hours of teacher of students' classses
      # office_hour.user == current_user.student_classrooms
      else
        user.student_office_hours
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

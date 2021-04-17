class OfficeHourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      # if teacher, show only own office hours
      elsif user.role == 'teacher'
        scope.where(user:user)
      # if parent, show office hours of teacher of students' classses
      # office_hour.user == current_user.student_classrooms
      else
        scope.where(record:user.student_office_hours)
        # ActiveRecord::Base.connection.execute(
        #     'select oh.* FROM users p
        #                   JOIN guardianships g ON g.user_id = p.id
        #                   JOIN students s ON s.id = g.student_id
        #                   JOIN enrollments e ON e.student_id = s.id
        #                   JOIN classrooms c ON c.id = e.classroom_id
        #                   JOIN users t ON t.id = c.user_id
        #                   JOIN office_hours oh ON oh.user_id = t.id
        #                   WHERE p.id = 4'
        #   ).each do |r| p OfficeHour.new(r) end
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
